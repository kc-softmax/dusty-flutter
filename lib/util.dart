import 'package:flame/game.dart';

Vector2 findPerpendicularPoint(Vector2 a, Vector2 b, Vector2 p) {
  // 직선 AB의 기울기 계산
  double slopeAB = (b.y - a.y) / (b.x - a.x);
  // 직선 AB에 수직인 선의 기울기 (AB의 역수의 음수)
  double slopePerpendicular = -1 / slopeAB;
  // 점 P에서 AB로 내린 수직선의 방정식은 y - p.y = slopePerpendicular * (x - p.x)
  // 이를 y = mx + c 형태로 변환하여 y절편 구하기
  double intercept = p.y - slopePerpendicular * p.x;

  // AB의 방정식은 y = slopeAB * x + c. 여기서 c 구하기
  double interceptAB = a.y - slopeAB * a.x;

  // 두 직선의 교점을 찾기 위해 연립방정식 풀이
  double xIntersection =
      (intercept - interceptAB) / (slopeAB - slopePerpendicular);
  double yIntersection = slopeAB * xIntersection + interceptAB;

  // 교점 반환
  return Vector2(xIntersection, yIntersection);
}
