// 질문의 응답에 따라 Animal의 index값을 정해주는 함수

int setAnimal(List<int> responses) {
  int result = 0;
  for(int i=0; i<responses.length; i++) {
    result += responses[i];
  }
  return result;
}