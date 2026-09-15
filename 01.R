#1 read data------------------------------------------------------------------------------------------------------------
getwd()
setwd("D:/myuser/mydesktop/TUKE/Ing/ZS_2024/Objavovanie Znalosti/01_Project/пытка часть вторая/data")
getwd()

accident <- read.csv("Accident_Information.csv") 
#------------------------------------------------------------------------------------------------------------------------

head(accident)
str(accident)









# Выбор признаков
# Создание копии данных для дальнейшей работы
accident_selected <- accident[, c(
  "X1st_Road_Class",
  "X2nd_Road_Class",
  "Accident_Severity",
  "Carriageway_Hazards",
  "Junction_Control",
  "Light_Conditions",
  "Number_of_Casualties", 
  "Number_of_Vehicles",
  "Road_Surface_Conditions",
  "Road_Type",
  "Speed_limit", 
  "Weather_Conditions"
 )]












# Преобразование категориальных признаков в числовые
accident_selected$X1st_Road_Class <- as.factor(accident_selected$X1st_Road_Class)
accident_selected$X1st_Road_Class <- as.numeric(accident_selected$X1st_Road_Class)

accident_selected$X2nd_Road_Class <- as.factor(accident_selected$X2nd_Road_Class)
accident_selected$X2nd_Road_Class <- as.numeric(accident_selected$X2nd_Road_Class)

accident_selected$Accident_Severity <- as.factor(accident_selected$Accident_Severity)
accident_selected$Accident_Severity <- as.numeric(accident_selected$Accident_Severity)

accident_selected$Carriageway_Hazards <- as.factor(accident_selected$Carriageway_Hazards)
accident_selected$Carriageway_Hazards <- as.numeric(accident_selected$Carriageway_Hazards)

accident_selected$Junction_Control <- as.factor(accident_selected$Junction_Control)
accident_selected$Junction_Control <- as.numeric(accident_selected$Junction_Control)

accident_selected$Light_Conditions <- as.factor(accident_selected$Light_Conditions)
accident_selected$Light_Conditions <- as.numeric(accident_selected$Light_Conditions)

accident_selected$Road_Surface_Conditions <- as.factor(accident_selected$Road_Surface_Conditions)
accident_selected$Road_Surface_Conditions <- as.numeric(accident_selected$Road_Surface_Conditions)

accident_selected$Road_Type <- as.factor(accident_selected$Road_Type)
accident_selected$Road_Type <- as.numeric(accident_selected$Road_Type)

accident_selected$Weather_Conditions <- as.factor(accident_selected$Weather_Conditions)
accident_selected$Weather_Conditions <- as.numeric(accident_selected$Weather_Conditions)













# Проверка на пропущенные значения
sum(is.na(accident_selected))
# Удаление строк с пропущенными значениями
accident_selected <- na.omit(accident_selected)
# Масштабирование данных
accident_scaled <- scale(accident_selected)











# Метод локтя для выбора числа кластеров
wss <- sapply(1:10, function(k) {
  kmeans(accident_scaled, centers = k, nstart = 25)$tot.withinss
})
# Построение графика метода локтя
plot(1:10, wss, type = "b", pch = 19, frame = FALSE, 
     xlab = "Количество кластеров", ylab = "Внутриклассовая сумма квадратов")
# Применение K-means кластеризации (например, 3 кластера)
set.seed(123)  # Устанавливаем сид для воспроизводимости












kmeans_result <- kmeans(accident_scaled, centers = 3, nstart = 25)
# Просмотр результатов кластеризации
kmeans_result$cluster












# Применение PCA для уменьшения размерности
pca_result <- prcomp(accident_scaled)
# Преобразование результатов PCA в DataFrame
accident_pca <- data.frame(pca_result$x)
# Добавляем метки кластеров
accident_pca$cluster <- factor(kmeans_result$cluster)












# Визуализация кластеров на 2D графике
library(ggplot2)
ggplot(accident_pca, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point() +
  labs(title = "K-means Clustering of Accidents", x = "Principal Component 1", y = "Principal Component 2")



setwd("D:/myuser/mydesktop/TUKE/Ing/ZS_2024/Objavovanie Znalosti/01_Project/пытка часть три")
getwd()
ggsave("kmeans_clustering_plot_3.png", plot = plot, width = 8, height = 6, dpi = 300)
