﻿#Область ДляВызоваИзДругихПодсистем

// Возвращает сведения о внешней обработке.
//Функция СведенияОВнешнейОбработке() Экспорт
//	
//	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке("2.4.5.71");
//	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
//		
//	ПараметрыРегистрации.Вид = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
//	ПараметрыРегистрации.Версия = "0.9.2";
//		
//	НоваяКоманда = ПараметрыРегистрации.Команды.Добавить();
//	НоваяКоманда.Представление = НСтр("ru = 'Настройка состава Истории изменений'");
//	НоваяКоманда.Идентификатор = "НастройкаСоставаИсторииИзменений";
//	НоваяКоманда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
//	НоваяКоманда.ПоказыватьОповещение = Ложь;  
//	
//	Возврат ПараметрыРегистрации;
//	
//КонецФункции

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

// Функция для возврата минимальной версии при которой будет работать история данных
Функция ПолучитьМинимальнуюВерсию()
	Возврат "8.3.11.2867";	
КонецФункции

// Функция возвращает все объекты по которым можно включить Историю изменений
// https://its.1c.ru/db/v8322doc#bookmark:dev:TI000001938 -> Глава 26. История данных
//	История данных поддерживается для следующих объектов:
//		общие реквизиты; (включено автоматически и программно менять нельзя)
//		константы;
//		планы обмена;
//		справочники;
//		документы;
//		планы видов характеристик;
//		планы счетов;
//		планы видов расчета;
//		бизнес-процессы;
//		задачи;
//		регистры сведений(Измерения включены по умолчанию и выключать их нельзя).
Функция ПолучитьСписокОбъектовМетаданных(ВерсияПлатформы) Экспорт	
	
	КлючиСтруктуры = "ИмяОбъекта, ObjectName, НомерКартинки, ДанныеПоиска";		
	
	// Все версии в которых были изменения
	СоответствиеВерсий = Новый Соответствие;   	
	минимальнаяВерсия = ПолучитьМинимальнуюВерсию();
	СоответствиеВерсий.Вставить(минимальнаяВерсия, 	ВерсияСтаршеИлиРавнаВерсии(ВерсияПлатформы, минимальнаяВерсия));
	СоответствиеВерсий.Вставить("8.3.12", 			ВерсияСтаршеИлиРавнаВерсии(ВерсияПлатформы, "8.3.12"));
    СоответствиеВерсий.Вставить("8.3.13", 			ВерсияСтаршеИлиРавнаВерсии(ВерсияПлатформы, "8.3.13"));
	//СоответствиеВерсий.Вставить("8.3.14", 			ВерсияСтаршеИлиРавнаВерсии(ВерсияПлатформы, "8.3.14"));
	//СоответствиеВерсий.Вставить("8.3.15", 			ВерсияСтаршеИлиРавнаВерсии(ВерсияПлатформы, "8.3.15"));
	
	СписокОбъектовМетаданных = Новый СписокЗначений;  	
	
	// Константы 
	Если СоответствиеВерсий["8.3.13"] Тогда  
		// Программно работать с общими реквизитами нельзя 	
		СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"Константы"
			,"Constant"
			,2
			,"")); 	
	КонецЕсли;
	
	// ПланыОбмена 
	Если СоответствиеВерсий["8.3.13"] Тогда 	
		СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"ПланыОбмена"
			,"ExchangePlan"
			,28
			,"СтандартныеРеквизиты,Реквизиты,ТабличныеЧасти"));
	КонецЕсли;	
	
	// Справочники
	Если СоответствиеВерсий[минимальнаяВерсия] Тогда
		СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"Справочники"
			,"Catalog"
			,4
			,"СтандартныеРеквизиты,Реквизиты,ТабличныеЧасти"));
	КонецЕсли;
	
	// Документы
	Если СоответствиеВерсий[минимальнаяВерсия] Тогда
		СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"Документы"
			,"Document"
			,8
			,"СтандартныеРеквизиты,Реквизиты,ТабличныеЧасти"));
	КонецЕсли;		
			
	// ПланыВидовХарактеристик		
	Если СоответствиеВерсий["8.3.12"] Тогда
		СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"ПланыВидовХарактеристик"
			,"ChartOfCharacteristicTypes"
			,10
			,"СтандартныеРеквизиты,Реквизиты,ТабличныеЧасти"));
	КонецЕсли;		
	
	// ПланыСчетов		
	Если СоответствиеВерсий["8.3.12"] Тогда	
		СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"ПланыСчетов"
			,"ChartOfAccounts"
			,12
			,"СтандартныеРеквизиты,Реквизиты,ТабличныеЧасти,СтандартныеТабличныеЧасти"));
			//"СтандартныеРеквизиты,Реквизиты,ПризнакиУчета,ПризнакиУчетаСубконто,ТабличныеЧасти,СтандартныеТабличныеЧасти"));  //+ПризнакиУчета,ПризнакиУчетаСубконто 
	КонецЕсли;		
	
	// ПланыВидовРасчета
	Если СоответствиеВерсий["8.3.13"] Тогда 		
	    СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"ПланыВидовРасчета"
			,"ChartsOfCalculationTypes"
			,14
			,"СтандартныеРеквизиты,Реквизиты,ТабличныеЧасти,СтандартныеТабличныеЧасти"));
	КонецЕсли;
	
	// РегистрыСведений
	Если СоответствиеВерсий[минимальнаяВерсия] Тогда
		СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"РегистрыСведений"
			,"InformationRegister"
			,16
			,"Измерения,Ресурсы,Реквизиты"));
			//,"Ресурсы,Реквизиты"));  // 20230619 
	КонецЕсли;		
			
	// БизнесПроцессы
	Если СоответствиеВерсий[минимальнаяВерсия] Тогда		
	    СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"БизнесПроцессы"
			,"BusinessProcess"
			,24
			,"СтандартныеРеквизиты,Реквизиты,ТабличныеЧасти")); 
	КонецЕсли;		
			
	// Задачи
	Если СоответствиеВерсий[минимальнаяВерсия] Тогда		
		СписокОбъектовМетаданных.Добавить(Новый Структура(КлючиСтруктуры 
			,"Задачи"
			,"Task"
			,26
			,"СтандартныеРеквизиты,Реквизиты,РеквизитыАдресации,ТабличныеЧасти"));		
    КонецЕсли;
	
	Возврат СписокОбъектовМетаданных;
	
КонецФункции	

// Определяет используюмую версию платформы.
//
// Возвращаемое значение:
//	Структура:
//   Отработал - Булево - Истина, функция возвращает нормальный результат, 
//   					Ложь означает, что результат получить неудалось.
//	 ТекстОшибки - Строка - Описание ошибки
//   Результат - Строка - Текущая версия конфигуратора или режима совместимости
//
Функция ТекущаяВерсияПлатформы() Экспорт 
	
	Результат = Новый Структура("Отработал, ТекстОшибки, Результат", Истина, "", 0);

	
	СовместимостьНеИспользовать = Метаданные.РежимСовместимости = Метаданные.СвойстваОбъектов.РежимСовместимости.НеИспользовать;
	
	Если СовместимостьНеИспользовать Тогда 
		
		АктуальнаяСистемнаяИнформация = Новый СистемнаяИнформация;
		
		// 8.3.11.2867
		перВерсияПриложения = АктуальнаяСистемнаяИнформация.ВерсияПриложения;  
					
	Иначе
		
		перВерсияПриложения = Строка(Метаданные.РежимСовместимости);
			
		// Версия8_3_15 -> 8_3_15
		перВерсияПриложения = СтрЗаменить(перВерсияПриложения, "Версия", "");
		
		// 8_3_15 -> 8.3.15
		перВерсияПриложения = СтрЗаменить(перВерсияПриложения, "_", ".");
		
	КонецЕсли;	
	
	// основная проверка
	минимальнаяВерсия = ПолучитьМинимальнуюВерсию();
	Если ВерсияСтаршеИлиРавнаВерсии(перВерсияПриложения, минимальнаяВерсия) Тогда
		
		Результат.Результат = перВерсияПриложения;	   
		
	Иначе
		
		Результат.Отработал = Ложь;
		Результат.ТекстОшибки = НСтр("ru = 'Версия платформы ("+перВерсияПриложения+"), необходима версия не ниже ("+минимальнаяВерсия+")'")
		
	КонецЕсли;	
					
    Возврат Результат;
	
КонецФункции

// Возвращает структуру по версии 
//	Параметры:
//		ВерсияПлатформы – Строка - Пример: "8.3.11.2867" 
//
// 	Возвращаемое значение:
// 	Структура:
//		НомерВерсии 	- Строка - Пример: "8"
//		НомерРедакции 	- Строка - Пример: "3"
//		НомерРелиза		- Строка - Пример: "11"
//		НомерПодрелиза 	- Строка - Пример: "2867"
Функция ВернутьСтруктуруПоВерсии(ВерсияПлатформы)
	
	массивРазделенныхЭлементов = СтрРазделить(ВерсияПлатформы, ".", Истина);    
	
	Если массивРазделенныхЭлементов.Количество() < 4 Тогда 
		Пока массивРазделенныхЭлементов.Количество() < 4 Цикл 
			массивРазделенныхЭлементов.Добавить("0");
		КонецЦикла;	
	КонецЕсли;
	
	СтруктураВерсияПриложения = Новый Структура("НомерВерсии, НомерРедакции, НомерРелиза, НомерПодрелиза"
						,массивРазделенныхЭлементов[0]
						,массивРазделенныхЭлементов[1]
						,массивРазделенныхЭлементов[2]
						,массивРазделенныхЭлементов[3]);

	Возврат СтруктураВерсияПриложения;
	
КонецФункции	

// Сравниваем две версии и возвращаем Истина если ПроверяемаяВерсия >= ЭталоннаяВерсия,
// в противном случае возвращаем Ложь
Функция ВерсияСтаршеИлиРавнаВерсии(ПроверяемаяВерсия, ЭталоннаяВерсия)
	
	СтруктураПроверяемаяВерсия 	= ВернутьСтруктуруПоВерсии(ПроверяемаяВерсия);	
	СтруктураЭталоннаяВерсия 	= ВернутьСтруктуруПоВерсии(ЭталоннаяВерсия);
	
	Результат = Истина;
	
	Если Число(СтруктураПроверяемаяВерсия.НомерВерсии) > Число(СтруктураЭталоннаяВерсия.НомерВерсии) Тогда 
		
		Возврат Результат;
		
	ИначеЕсли Число(СтруктураПроверяемаяВерсия.НомерВерсии) < Число(СтруктураЭталоннаяВерсия.НомерВерсии) Тогда 
		
		Результат = Ложь;
		
	Иначе // СтруктураПроверяемаяВерсия.НомерВерсии = СтруктураЭталоннаяВерсия
		
		Если Число(СтруктураПроверяемаяВерсия.НомерРедакции) > Число(СтруктураЭталоннаяВерсия.НомерРедакции) Тогда
			
			Возврат Результат;
		
		ИначеЕсли Число(СтруктураПроверяемаяВерсия.НомерРедакции) < Число(СтруктураЭталоннаяВерсия.НомерРедакции) Тогда
			
			Результат = Ложь;
			
		Иначе // СтруктураПроверяемаяВерсия.НомерРедакции = СтруктураЭталоннаяВерсия.НомерРедакции
			
			Если Число(СтруктураПроверяемаяВерсия.НомерРелиза) > Число(СтруктураЭталоннаяВерсия.НомерРелиза) Тогда
				
				Возврат Результат;	
			
			ИначеЕсли Число(СтруктураПроверяемаяВерсия.НомерРелиза) < Число(СтруктураЭталоннаяВерсия.НомерРелиза) Тогда 
				
				Результат = Ложь;
				
			Иначе  // СтруктураПроверяемаяВерсия.НомерРелиза = СтруктураЭталоннаяВерсия.НомерРелиза
				
				Если СтруктураПроверяемаяВерсия.НомерПодрелиза <> "0" Тогда 
					
					Если Число(СтруктураПроверяемаяВерсия.НомерПодрелиза) > Число(СтруктураЭталоннаяВерсия.НомерПодрелиза) Тогда
				
						Возврат Результат;	
					
					ИначеЕсли Число(СтруктураПроверяемаяВерсия.НомерПодрелиза) < Число(СтруктураЭталоннаяВерсия.НомерПодрелиза) Тогда 
						
						Результат = Ложь;
						
					Иначе 
						
						Возврат Результат;
						
				    КонецЕсли; // НомерПодрелиза
				КонецЕсли; // НомерПодрелиза <> "0"
			КонецЕсли; // НомерРелиза	
        КонецЕсли; // НомерРедакции
	КонецЕсли; // НомерВерсии	
	
	Возврат Результат;
	
КонецФункции	

// Рекурсивное обслуживание иерархических пометок с тремя состояниями в дереве. 
//
// Параметры:
//    ДанныеСтроки - ДанныеФормыЭлементДерева - Пометка хранится в числовой колонке "Пометка".
//
Процедура ИзменениеПометки(ДанныеСтроки) Экспорт  
	
	ДанныеСтроки.Пометка = ДанныеСтроки.Пометка % 2;
	ПроставитьПометкиВниз(ДанныеСтроки);
	ПроставитьПометкиВверх(ДанныеСтроки);      
	
КонецПроцедуры

// Рекурсивное обслуживание иерархических пометок с тремя состояниями в дереве. 
//
// Параметры:
//    ДанныеСтроки - ДанныеФормыЭлементДерева - Пометка хранится в числовой колонке "Пометка".
//
Процедура ПроставитьПометкиВниз(ДанныеСтроки) Экспорт 
	
	Значение = ДанныеСтроки.Пометка;
	Для Каждого Потомок Из ДанныеСтроки.ПолучитьЭлементы() Цикл
		Потомок.Пометка = Значение;
		ПроставитьПометкиВниз(Потомок); 
	КонецЦикла;
	
КонецПроцедуры

// Рекурсивное обслуживание иерархических пометок с тремя состояниями в дереве. 
//
// Параметры:
//    ДанныеСтроки - ДанныеФормыЭлементДерева - Пометка хранится в числовой колонке "Пометка".
//
Процедура ПроставитьПометкиВверх(ДанныеСтроки) Экспорт 
	
	РодительСтроки = ДанныеСтроки.ПолучитьРодителя();
	Если РодительСтроки <> Неопределено Тогда
		ВсеИстина = Истина;
		НеВсеЛожь = Ложь;
		Для Каждого Потомок Из РодительСтроки.ПолучитьЭлементы() Цикл
			ВсеИстина = ВсеИстина И (Потомок.Пометка = 1);
			НеВсеЛожь = НеВсеЛожь Или Булево(Потомок.Пометка);
		КонецЦикла;
		Если ВсеИстина Тогда
			РодительСтроки.Пометка = 1;
		ИначеЕсли НеВсеЛожь Тогда
			РодительСтроки.Пометка = 2;
		Иначе
			РодительСтроки.Пометка = 0;
		КонецЕсли;
		ПроставитьПометкиВверх(РодительСтроки);
	КонецЕсли;  
	
КонецПроцедуры

#КонецОбласти
