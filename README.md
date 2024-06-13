# 동물 랜덤채팅 어플리케이션

### Frond-end: Flutter    
   
### Back-end: Node.js, Socket.io
     
단국대학교 24년 1학기 모바일 플랫폼 기말 프로젝트로 제작한 랜덤 채팅 애플리케이션 입니다.

사용자는 간단한 질문 (3가지)를 통해 자신에게 어울리는 동물 이미지 (개, 고양이, 새, 물고기) 중 하나를 배정 받습니다.

실시간 통신을 위해 웹소켓 기반의 Socket.io를 활용했습니다.

서버 단에서 매칭 시작, 매칭 취소, 채팅방 입장, 채팅 메세지 전송, 채팅방 퇴장 총 5개의 이벤트를 제어하고 처리합니다.

추후 여유가 된다면 서버 동기화를 위해 락스텝 구조를 적용해볼 계획입니다.
