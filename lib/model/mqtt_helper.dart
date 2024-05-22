import 'dart:math';

String predictWeather(double temperature, double humidity) {
  // Tham số của model Logistic Regression có thể thay đổi tùy theo tập dữ liệu cụ thể
  double beta0 = -0.5;
  double beta1 = 0.2;
  double beta2 = 0.1;

  // Tính xác suất thời tiết nắng
  double probability = 1 / (1 + exp(-(beta0 + beta1 * temperature + beta2 * humidity)));

  // Ngưỡng xác suất để dự đoán thời tiết
  double threshold = 0.5;

  return probability >= threshold ? "Nắng" : "Mưa";
}
