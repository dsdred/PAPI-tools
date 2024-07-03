# Инструменты для подсиcтемы PAPI

[![OpenYellow](https://img.shields.io/endpoint?url=https://openyellow.neocities.org/badges/4/763113633.json)](https://openyellow.notion.site/openyellow/24727888daa641af95514b46bee4d6f2?p=e89925d9c00f439d8ef210fc5445f8db&pm=s)

Первоначально инструменты будут обновляется в этом репозитории. После накопления определенного количества фич будут перетекать в подсистему PAPI.
Все обработки самодостаточные, работают без сторонних и типовых библиотек.

Обработки \*.epf лежат в статьях

![Infostart](/assets/img/svg/infostartlogo.svg)

Исходники выгружены платформой `8.3.24.1548`

### Состав:

1. **Сообщения сервисов интеграции** `V2024.05.06`

_Инструмент из разряда «MustHave». Позволяет отслеживать какие и сколько сообщений находятся в канале и не только._

Возможности:

- [x] Показывает сколько сообщений находится в каналах
- [x] Включение и отключение авто обновления формы
- [x] Показывает подключены ли каналы к 1С:Шине
- [x] Производит отборы сообщений
- [x] Просматривает свойства и параметры сообщений
- [x] Удаляет ненужные сообщения
- [x] Совместимость с 8.3.21
- [x] Просмотр тела сообщения
- [x] Добавлена заготовка для БСП (Дополнительные обработки и отчеты). Функция СведенияОВнешнейОбработке() `new`
- [ ] Совместимость с 8.3.18
- [ ] Сохранение сообщения или передача в другой канал

Известные баги платформы:

- [HL-769780](https://bugboard.v8.1c.ru/error/000150912): На текущий момент есть баг по выборке количества сообщений. В платформе оно не работает из-за чего выбираются все подходящие под отбор сообщения.

  **Баг исправлен:**

  - [x] Исправлена: "Технологическая платформа", версия 8.3.24.1624
  - [x] Исправлена: "Технологическая платформа", версия 8.3.25.1336
  - [x] Планируется исправить: "Технологическая платформа", версия 8.3.22.2557
  - [ ] Планируется исправить: "Технологическая платформа", версия 8.3.23

- [HL-802851](https://regevent.1c.ru/sbo/tp/c3d2f281-dc5c-11ee-8161-0050569f2415/info/): Не работает отбор по свойству «ИдентификаторСообщенияЗапроса» по значению "00000000-0000-0000-0000-000000000000".

| [Исходники](/src/IntegrationServicesMessages/) | [Скачать epf файл](https://infostart.ru/1c/tools/2050054/) |

---

1. **Настройка сервисов интеграции** `V2024.05.07`

_Инструмент повторяет типовой функционал, но имеет несколько особенностей._

Возможности:

- [x] Настройки расположены под списком, что позволяет быстрее настраивать каналы, не открывая постоянно еще одно окно
- [x] Кнопка показать пароль
- [x] Совместимость с 8.3.17
- [x] Получение настроек в формате JSON
- [x] Запись настроек на основе JSON
- [x] Добавлена заготовка для БСП (Дополнительные обработки и отчеты). Функция СведенияОВнешнейОбработке() `new`

| [Исходники](/src/IntegrationServicesSettings/) | [Скачать epf файл](https://infostart.ru/1c/tools/2050054/) |

---

1. **Отправка сообщения сервисов интеграции** `V2024.07.04`

_Инструмент позволяет создать сообщение сервиса интеграции на выбранном канале._

Возможности:

- [x] Позволяет отправить сообщение в нужный канал выбранным получателям
- [x] Возможность указать идентификатор сообщения, на который будет отправлен ответ
- [x] Позволяет вставлять произвольный текст сообщения
- [x] Кнопка запуска фонового задания по работе с 1С:Шиной
- [x] Кнопка остановки фонового задания по работе с 1С:Шиной
- [x] Совместимость с 8.3.17
- [x] Добавлена заготовка для БСП (Дополнительные обработки и отчеты). Функция СведенияОВнешнейОбработке()
- [x] Добавлена проверка на Минимальную версию платформы 8.3.17. Если платформа меньше, функционал будет отсутствовать `new`
- [x] Добавлена проверка на версию платформы 8.3.21. Если версия больше или равна тогда появится возможность снять галочку создающую параметр "РазмерСообщения" `new`
- [ ] Заполнение на основании сообщения

| [Исходники](/src/SendingMessageIntegrationServices/) | [Скачать epf файл](https://infostart.ru/1c/tools/2050054/) |

---

1. **Настройка состава истории данных** `V2024.05.07`

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
- [x] Добавлена заготовка для БСП (Дополнительные обработки и отчеты). Функция СведенияОВнешнейОбработке() `new`

| [Исходники](/src/DataHistorySettings/) | [Скачать epf файл](https://infostart.ru/1c/tools/1808124/) | [Сравнение со стандартной обработкой](https://infostart.ru/1c/tools/1882953/)

---

Все обработки выложены под [MIT лицензией](https://mit-license.org/)
