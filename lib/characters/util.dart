bool getFlippedHorizontally(int currentIndex, int targetDirectionIndex) {
  // 인덱스 차이 계산
  int indexDifference = (targetDirectionIndex - currentIndex) % 12;
  // 인덱스 차이를 -6 ~ 5 범위로 정규화
  if (indexDifference > 6) {
    indexDifference -= 12;
  } else if (indexDifference < -6) {
    indexDifference += 12;
  }

  // 회전 방향 결정:
  // 인덱스 차이가 양수이면 시계 방향 회전이 필요,
  // 인덱스 차이가 음수이면 반시계 방향 회전이 필요
  // 통상적으로, 캐릭터가 왼쪽을 바라볼 때(즉, 시계 반대 방향으로 회전할 때) 수평으로 뒤집히게 설정
  return indexDifference > 0 && indexDifference <= 6;
}
