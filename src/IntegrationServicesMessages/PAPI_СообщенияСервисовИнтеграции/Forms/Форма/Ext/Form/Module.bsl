﻿
//MIT License

//Copyright (c) 2024 Dmitrii Sidorenko

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка) 
	
	перОтключен = СостояниеКаналаСервисаИнтеграции.Отключен;
	Для Каждого текСервис Из Метаданные.СервисыИнтеграции Цикл 
		
		Для Каждого текКанал Из текСервис.КаналыСервисаИнтеграции Цикл 
		
			НоваяСтрока = Список.Добавить(); 
			НоваяСтрока.Сервис	= текСервис.Имя;
			НоваяСтрока.Канал	= текКанал.Имя;    
			
			НоваяСтрока.Состояние	= ?(СервисыИнтеграции[текСервис.Имя][текКанал.Имя].ПолучитьСостояние() = перОтключен, 1, 0);
			НоваяСтрока.Направление = Строка(текКанал.НаправлениеСообщения);
			НоваяСтрока.ВнешнееИмя  = текКанал.ИмяКаналаВнешнегоСервисаИнтеграции;
			
			НоваяСтрока.Количество = СервисыИнтеграции[текСервис.Имя][текКанал.Имя].ВыбратьСообщения().Количество(); 
			
		КонецЦикла;
	
	КонецЦикла;    
	
	АвтоОбновлениеСписка = Истина;
	ПериодОбновленияСписка = 30;
	
	// Включаем видимость страницы отборы и отборы в поиске сообщений
	ВключитьОтборы = Истина;
	
	// Страница "Отборы"
	ОтборИдентификатор = Ложь;
	ОтборИдентификаторСообщенияЗапроса = Ложь;
	ОтборДатыОтправки = Ложь;
	ОтборДатаУстаревания = Ложь; 
	ОтборОтправителя = Ложь;
	ОтборПолучателя = Ложь;
	ОтборПараметрыСообщения = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ВидимостьИДоступностьЭлементов();
	
	// Обновление списка
	Если АвтоОбновлениеСписка Тогда 
		ПодключитьОбработчикОжидания("ОбновитьСтатусыКаналов", ПериодОбновленияСписка, Истина);  
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСписок

&НаКлиенте
Процедура ОбновитьСтатусыКаналов()
	
	ОбновитьСтатусыКаналовНаСервере();
	
	// Обновление списка
	Если АвтоОбновлениеСписка Тогда 
		ПодключитьОбработчикОжидания("ОбновитьСтатусыКаналов", ПериодОбновленияСписка, Истина);  
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		Сервис = ТекущиеДанные.Сервис;
		Канал  = ТекущиеДанные.Канал;
		
		Если СписокСообщений.Количество() > 0 Тогда 
			СписокСообщений.Очистить();
		КонецЕсли;	
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОтобратьСообщения(Команда)
	
	ОтобратьНаСервере(); 
    Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаСообщения;
	
КонецПроцедуры

&НаКлиенте
Процедура АвтоОбновлениеСпискаПриИзменении(Элемент)
	
	Если АвтоОбновлениеСписка Тогда 
		ПодключитьОбработчикОжидания("ОбновитьСтатусыКаналов", ПериодОбновленияСписка, Истина);  
	КонецЕсли;

КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСписокСообщений

&НаКлиенте
Процедура Отобрать(Команда)
	
	ОтобратьНаСервере();  
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьВсеСообщения(Команда) 
		
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ОчиститьВсеСообщенияНаСервере(ТекущиеДанные.Сервис, ТекущиеДанные.Канал);
		
		ДанныеДляЗаполнения = ПолучитьСостояниеИКоличествоСообщений(ТекущиеДанные.Сервис, ТекущиеДанные.Канал);
			
		ТекущиеДанные.Состояние	 = ДанныеДляЗаполнения.Состояние;
		ТекущиеДанные.Количество = ДанныеДляЗаполнения.Количество;   
		
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФлажки(Команда)
	
	Если СписокСообщений.Количество() > 0 Тогда 
		Для Каждого ТекущиеДанные Из СписокСообщений Цикл  
			
			Если Не ТекущиеДанные.Пометка Тогда 
				ТекущиеДанные.Пометка = Истина;
			КонецЕсли;
			
		КонецЦикла;	
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	
	Если СписокСообщений.Количество() > 0 Тогда 
		Для Каждого ТекущиеДанные Из СписокСообщений Цикл
			
			Если ТекущиеДанные.Пометка Тогда  
				ТекущиеДанные.Пометка = Ложь;	
			КонецЕсли;	
				
		КонецЦикла;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьТело(Команда)
	
	ТекущиеДанные = Элементы.СписокСообщений.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ИдентификаторСообщения = ТекущиеДанные.Идентификатор;

		Если Не ТекущиеДанные.ТелоПрочитано
			И ЗначениеЗаполнено(ИдентификаторСообщения)
			И ЗначениеЗаполнено(Сервис)
			И ЗначениеЗаполнено(Канал) Тогда 
			
			ТекущиеДанные.ТелоПрочитано = Истина;
			ТекущиеДанные.ТелоСообщения = ПолучитьТелоНаСервере(ИдентификаторСообщения, Сервис, Канал);
			
			ТелоСообщения = ТекущиеДанные.ТелоСообщения;
			
		КонецЕсли;
		
		Элементы.СтраницыПараметрыТело.ТекущаяСтраница = Элементы.СтраницаТело;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьТелоНаСервере(ИдентификаторСообщения, Сервис, Канал)
	
	Результат = "";
	
	Отбор = Новый Структура;
	Если ЗначениеЗаполнено(ИдентификаторСообщения) Тогда 
		Отбор.Вставить("Идентификатор", ИдентификаторСообщения);
		СообщенияСервиса = СервисыИнтеграции[Сервис][Канал].ВыбратьСообщения(Отбор, 1);   
		
		Если СообщенияСервиса.Количество() > 0 Тогда  
		
			текСообщение = СообщенияСервиса[0];
			
			// Доступен, начиная с версии 8.3.21.
			РазмерСообщения = текСообщение.РазмерТела;   
			
			// TODO: поддержка совместимости с 8.3.18
			// РазмерСообщения = текСообщение.Параметры.Получить("РазмерСообщения"); 
			Если РазмерСообщения <> Неопределено Тогда
				РазмерБуфера = Число(РазмерСообщения); 
			Иначе
				РазмерБуфера = 1024;    
			КонецЕсли;

		    // Читаем тело сообщения++         
			Если РазмерБуфера = 0 Тогда 
				
				ВходящееСообщение = "";
				
			Иначе
				
				Тело  = Новый БуферДвоичныхДанных(0);
				Буфер = Новый БуферДвоичныхДанных(РазмерБуфера);
				Поток = текСообщение.ПолучитьТелоКакПоток();	
				
				Пока Истина Цикл
					
					Прочитано = Поток.Прочитать(Буфер, 0, РазмерБуфера);
					
					Если Прочитано > 0 Тогда
						
						Тело = Тело.Соединить(Буфер);  
						
					КонецЕсли;   
					
					Если Прочитано < РазмерБуфера Тогда
						
						Прервать; 
						
			 		КонецЕсли; 
					
				КонецЦикла; 
				
				ВходящееСообщение = ПолучитьСтрокуИзБуфераДвоичныхДанных(Тело);   
				
			КонецЕсли;
				 
			Результат = ВходящееСообщение;
		    // Читаем тело сообщения--
			
		КонецЕсли;
		
	КонецЕсли;	
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура СписокСообщенийПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.СписокСообщений.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ТелоСообщения = ТекущиеДанные.ТелоСообщения;
		
	Иначе
		
		ТелоСообщения = "";	
		
	КонецЕсли;	

КонецПроцедуры

&НаКлиенте
Процедура УдалитьСообщенияВыборочно(Команда)  
	
	УдалитьСообщенияВыборочноНаСервере();	
		
КонецПроцедуры

&НаСервере
Процедура УдалитьСообщенияВыборочноНаСервере()  
	 
	МассивУдаляемыхСообщений = Новый Массив; 
	Для Каждого ТекущиеДанные Из СписокСообщений Цикл 
		Если ТекущиеДанные.Пометка Тогда
			МассивУдаляемыхСообщений.Добавить(ТекущиеДанные.Идентификатор);
		КонецЕсли;	
	КонецЦикла;	     	
	
	Если МассивУдаляемыхСообщений.Количество() > 0 Тогда 
		
		ОчиститьВсеСообщенияНаСервере(Сервис, Канал, МассивУдаляемыхСообщений);
		
	КонецЕсли;	
	
	ОтобратьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ВключитьОтборыПриИзменении(Элемент)  
	
	ВидимостьИДоступностьЭлементов();
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСтраницаОтборы

&НаКлиенте
Процедура ОтборИдентификаторПриИзменении(Элемент)  
	
	ВидимостьИДоступностьЭлементов(); 
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборИдентификаторСообщенияЗапросаПриИзменении(Элемент)
	
	ВидимостьИДоступностьЭлементов(); 
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборДатыОтправкиПриИзменении(Элемент)
	
	ВидимостьИДоступностьЭлементов();

КонецПроцедуры

&НаКлиенте
Процедура ОтборДатаУстареванияПриИзменении(Элемент)
	
	ВидимостьИДоступностьЭлементов();

КонецПроцедуры

&НаКлиенте
Процедура ОтборОтправителяПриИзменении(Элемент)
	
	ВидимостьИДоступностьЭлементов();

КонецПроцедуры

&НаКлиенте
Процедура ОтборПолучателяПриИзменении(Элемент)
	
	ВидимостьИДоступностьЭлементов();

КонецПроцедуры

&НаКлиенте
Процедура ОтборПараметрыСообщенияПриИзменении(Элемент)

	ВидимостьИДоступностьЭлементов();
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьСтатусыКаналовНаСервере()
	
	перОтключен = СостояниеКаналаСервисаИнтеграции.Отключен;	
	Для Каждого текСтрока Из Список Цикл 
		
		текСтрока.Состояние	= ?(СервисыИнтеграции[текСтрока.Сервис][текСтрока.Канал].ПолучитьСостояние() = перОтключен, 1, 0);
		текСтрока.Количество = СервисыИнтеграции[текСтрока.Сервис][текСтрока.Канал].ВыбратьСообщения().Количество();   
		
	КонецЦикла;	

КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьСостояниеИКоличествоСообщений(Сервис, Канал)  
	
	перОтключен = СостояниеКаналаСервисаИнтеграции.Отключен;
	
	Результат = Новый Структура("Состояние, Количество",
	?(СервисыИнтеграции[Сервис][Канал].ПолучитьСостояние() = перОтключен, 1, 0),
	СервисыИнтеграции[Сервис][Канал].ВыбратьСообщения().Количество());
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ОтобратьНаСервере()
	
	Отбор = Новый Структура;
	Если ВключитьОтборы Тогда
		
		Если ОтборИдентификатор И ЗначениеЗаполнено(Идентификатор) Тогда 
			Попытка
				Отбор.Вставить("Идентификатор", Новый УникальныйИдентификатор(Идентификатор));
			Исключение	
				ОтборИдентификатор = Ложь; // При ошибке отключаем отбор	
			КонецПопытки;	
		КонецЕсли;	  
		
		Если ОтборИдентификаторСообщенияЗапроса 
			И (ЗначениеЗаполнено(ИдентификаторСообщенияЗапроса) 
			ИЛИ ИдентификаторСообщенияЗапроса = "00000000-0000-0000-0000-000000000000") Тогда  
			Попытка
				Отбор.Вставить("ИдентификаторСообщенияЗапроса", Новый УникальныйИдентификатор(ИдентификаторСообщенияЗапроса));	
			Исключение
				ОтборИдентификаторСообщенияЗапроса = Ложь; // При ошибке отключаем отбор
			КонецПопытки;	
		КонецЕсли;  
			
		
		Если ОтборДатыОтправки И ЗначениеЗаполнено(ДатаОтправкиНачало) Тогда 
			Отбор.Вставить("ДатаОтправкиНачало", ДатаОтправкиНачало);	
		КонецЕсли;
	    Если ОтборДатыОтправки И ЗначениеЗаполнено(ДатаОтправкиОкончание) Тогда 
			Отбор.Вставить("ДатаОтправкиОкончание", ДатаОтправкиОкончание);	
		КонецЕсли;
		Если ОтборДатаУстаревания И ЗначениеЗаполнено(ДатаУстареванияНачало) Тогда 
			Отбор.Вставить("ДатаУстареванияНачало", ДатаУстареванияНачало);	
		КонецЕсли;
		Если ОтборДатаУстаревания И ЗначениеЗаполнено(ДатаУстареванияОкончание) Тогда 
			Отбор.Вставить("ДатаУстареванияОкончание", ДатаУстареванияОкончание);	
		КонецЕсли;

		Если ОтборОтправителя И ЗначениеЗаполнено(КодОтправителя) Тогда 
			Отбор.Вставить("КодОтправителя", КодОтправителя);	
		КонецЕсли;
		Если ОтборПолучателя И ЗначениеЗаполнено(КодПолучателя) Тогда 
			Отбор.Вставить("КодПолучателя", КодПолучателя);	
		КонецЕсли;
		
	
		Если ОтборПараметрыСообщения И ПараметрыСообщения.Количество() > 0 Тогда 
			
			ПараметрыОтбора = Новый Соответствие;
			Для Каждого текПараметр Из ПараметрыСообщения Цикл 
				
				ПараметрыОтбора.Вставить(текПараметр.Ключ, текПараметр.Значение);	
				
			КонецЦикла;	
			
			Если ЗначениеЗаполнено(ПараметрыОтбора) Тогда 
				Отбор.Вставить("Параметры", ПараметрыОтбора);
			КонецЕсли;	
			
		КонецЕсли;	
	КонецЕсли; 
	
	Если ЗначениеЗаполнено(Отбор) И КоличествоСообщений > 0 Тогда 
		СообщенияСервиса = СервисыИнтеграции[Сервис][Канал].ВыбратьСообщения(Отбор, КоличествоСообщений);	
	ИначеЕсли ЗначениеЗаполнено(Отбор) Тогда 
		СообщенияСервиса = СервисыИнтеграции[Сервис][Канал].ВыбратьСообщения(Отбор);
	ИначеЕсли КоличествоСообщений > 0 Тогда 
		СообщенияСервиса = СервисыИнтеграции[Сервис][Канал].ВыбратьСообщения(Неопределено, КоличествоСообщений);	
	Иначе 	
		СообщенияСервиса = СервисыИнтеграции[Сервис][Канал].ВыбратьСообщения();
    КонецЕсли;
		
	Если СписокСообщений.Количество() > 0 Тогда 
		СписокСообщений.Очистить();
	КонецЕсли;
		
	Для Каждого текСообщение Из СообщенияСервиса Цикл 
		
		новСообщение = СписокСообщений.Добавить();
		
		новСообщение.Идентификатор 					= текСообщение.Идентификатор;
		новСообщение.ИдентификаторСообщенияЗапроса 	= текСообщение.ИдентификаторСообщенияЗапроса;
		новСообщение.ДатаОтправки	 				= текСообщение.ДатаОтправки;
		новСообщение.ДатаУстаревания 				= текСообщение.ДатаУстаревания;
		новСообщение.КодОтправителя 				= текСообщение.КодОтправителя;
		новСообщение.КодПолучателя 					= текСообщение.КодПолучателя;
		
		новСообщение.РазмерТела 					= текСообщение.РазмерТела;
		
		Для Каждого текПараметр Из текСообщение.Параметры Цикл 
			
			новПараметр = новСообщение.ПараметрыСообщения.Добавить();
			ЗаполнитьЗначенияСвойств(новПараметр,текПараметр);
			
		КонецЦикла;
		
	КонецЦикла;	
		
КонецПроцедуры


&НаСервереБезКонтекста
Процедура ОчиститьВсеСообщенияНаСервере(Сервис, Канал, МассивСообщений = Неопределено)  
	
	Если ЗначениеЗаполнено(МассивСообщений) Тогда 
		СервисыИнтеграции[Сервис][Канал].УдалитьСообщения(МассивСообщений);	
	Иначе 	
		СервисыИнтеграции[Сервис][Канал].УдалитьСообщения();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВидимостьИДоступностьЭлементов()
	
	Элементы.СтраницаОтбора.Видимость = ВключитьОтборы;
	
	Элементы.Идентификатор.Доступность = ОтборИдентификатор;      
	Элементы.ИдентификаторСообщенияЗапроса.Доступность = ОтборИдентификаторСообщенияЗапроса; 
	
	Элементы.ДатаОтправкиНачало.Доступность = ОтборДатыОтправки;
	Элементы.ДатаОтправкиОкончание.Доступность = ОтборДатыОтправки;
	
	Элементы.ДатаУстареванияНачало.Доступность = ОтборДатаУстаревания;
	Элементы.ДатаУстареванияОкончание.Доступность = ОтборДатаУстаревания;

	Элементы.КодОтправителя.Доступность = ОтборОтправителя;
	Элементы.КодПолучателя.Доступность = ОтборПолучателя;
	
	Элементы.ПараметрыСообщения.Доступность = ОтборПараметрыСообщения;
	Элементы.ГруппаКППараметрыСообщения.Доступность = ОтборПараметрыСообщения;
	
КонецПроцедуры	

#КонецОбласти
