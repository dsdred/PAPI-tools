# Инструменты для подсиcтемы PAPI

Первоначально инструменты будут обновляется в этом репозитории. После накопления определенного количества фич будут перетекать в подсистему PAPI.
Все обработки самодостаточные, работают без сторонних и типовых библиотек.

Обработки \*.epf лежат в статьях

![Infostart](/assets/img/svg/infostartlogo.svg)

Исходники выгружены платформой `8.3.24.1368`

### Состав:

1. **Сообщения сервисов интеграции** `V2024.03.01`

_Инструмент из разряда «MustHave». Позволяет отслеживать какие и сколько сообщений находятся в канале и не только._

Возможности:

- [x] Показывает сколько сообщений находится в каналах
- [x] Включение и отключение авто обновления формы
- [x] Показывает подключены ли каналы к 1С:Шине
- [x] Производит отборы сообщений
- [x] Просматривает свойства и параметры сообщений
- [x] Удаляет ненужные сообщения
- [x] Совместимость с 8.3.21
- [x] Просмотр тела сообщения `new`
- [ ] Совместимость с 8.3.18
- [ ] Сохранение сообщения или передача в другой канал

Известные баги платформы:

- На текущий момент есть баг по выборке количества сообщений. В платформе оно не работает из-за чего выбираются все подходящие под отбор сообщения. Баг отправлен в 1С, ждем, когда поправят.
- Не работает отбор по свойству «ИдентификаторСообщенияЗапроса» по значению "00000000-0000-0000-0000-000000000000". Пока не отправлено в 1С, не решил баг это или фича.

| [Исходники](/src/IntegrationServicesMessages/) | [Скачать epf файл](https://infostart.ru/1c/tools/2050054/) |

---

2. **Настройка сервисов интеграции** `V2024.02.23`

_Инструмент повторяет типовой функционал, но имеет несколько особенностей._

Возможности:

- [x] Настройки расположены под списком, что позволяет быстрее настраивать каналы, не открывая постоянно еще одно окно
- [x] Кнопка показать пароль
- [x] Совместимость с 8.3.17

| [Исходники](/src/IntegrationServicesSettings/) | [Скачать epf файл](https://infostart.ru/1c/tools/2050054/) |

---

3. **Отправка сообщения сервисов интеграции** `V2024.02.24`

_Инструмент позволяет создать сообщение сервиса интеграции на выбранном канале._

Возможности:

- [x] Позволяет отправить сообщение в нужный канал выбранным получателям
- [x] Возможность указать идентификатор сообщения, на который будет отправлен ответ
- [x] Позволяет вставлять произвольный текст сообщения
- [x] Кнопка запуска фонового задания по работе с 1С:Шиной
- [x] Кнопка остановки фонового задания по работе с 1С:Шиной
- [x] Совместимость с 8.3.17
- [ ] Заполнение на основании сообщения

| [Исходники](/src/SendingMessageIntegrationServices/) | [Скачать epf файл](https://infostart.ru/1c/tools/2050054/) |

---

4. **Настройка состава истории данных** `V2023.06.19`

_Инструмент позволяет программно включать и выключать историю данных_

Возможности:

- [x] Включение и выключение истории данных по следующим объектам:
  - константы
  - планы обмена
  - справочники
  - документы
  - планы видов характеристик;
  - планы счетов
  - планы видов расчета
  - бизнес-процессы
  - задачи
  - регистры сведений
- [x] Графически отображает включена история данных программно \ в конфигураторе
- [x] Позволяет включать историю данных под привилигированными правами
- [x] графически отображает тип реквизита по объекту
- [x] Совместимость с 8.3.11.2867

| [Исходники](/src/DataHistorySettings/) | [Скачать epf файл](https://infostart.ru/1c/tools/1808124/) | [Сравнение со стандартной обработкой](https://infostart.ru/1c/tools/1882953/)

---

Все обработки выложены под [MIT лицензией](https://mit-license.org/)
