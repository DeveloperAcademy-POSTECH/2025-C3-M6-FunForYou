/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onSchedule } = require("firebase-functions/v2/scheduler");
const { initializeApp } = require("firebase-admin/app");
const { getDatabase } = require("firebase-admin/database");
const { getMessaging } = require("firebase-admin/messaging");
const { setGlobalOptions } = require("firebase-functions/v2");

// 기본 초기화 (App 단일 인스턴스)
initializeApp();

// 글로벌 설정 (서울 리전 추천)
setGlobalOptions({ region: "asia-northeast3" });

exports.sendDailyNotifications = onSchedule(
  {
    schedule: "* * * * *", // 테스트용 매 1분마다 실행
    timeZone: "Asia/Seoul", // 한국 시간 기준
  },
  async () => {
    try {
      const db = getDatabase();
      const snapshot = await db.ref().once("value");

      const tokens = new Set();

      snapshot.forEach((child) => {
        const token = child.val();
        if (typeof token === "string" && token.trim() !== "") {
          tokens.add(token);
          console.log(token);
        }
      });

      const tokenArray = Array.from(tokens);

      if (tokenArray.length === 0) {
        console.log("No FCM tokens found.");
        return;
      }

      const message = {
        notification: {
          title: "좋은 아침입니다 🌞",
          body: "오늘 하루도 힘내세요!",
        },
        tokens: tokenArray,
      };

      const response = await getMessaging().sendEachForMulticast(message);
      console.log(`✅ 알림 전송 성공: ${response.successCount}`);

      if (response.failureCount > 0) {
        response.responses.forEach((resp, i) => {
          if (!resp.success) {
            console.error(
              `❌ 실패: ${tokenArray[i]} - ${resp.error && resp.error.message}`
            );
          }
        });
      }
    } catch (error) {
      console.error("🔥 알림 전송 중 오류 발생:", error);
    }
  }
);
