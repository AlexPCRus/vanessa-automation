﻿
#Область ОписаниеПеременных

&НаКлиенте
Перем Ванесса, ТочкаX1, ТочкаY1;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ДескрипторОсновногоОкнаТекущегоКлиентаТестирования = Параметры.ДескрипторОсновногоОкнаТекущегоКлиентаТестирования;
	ДескрипторОсновногоОкнаVA = Параметры.ДескрипторОсновногоОкнаVA; 
	
	// Заполнение данных для механизма "КонструкцияШагаПрочие".
	КонструкцияШагаПрочиеТаблицаЗаполнение();   
	Для Каждого СтрокаДанных Из КонструкцияШагаПрочиеТаблица Цикл
		Элементы.КонструкцияШагаПрочие.СписокВыбора.Добавить(СтрокаДанных.Представление);  
	КонецЦикла;
	Элементы.КонструкцияШагаПрочиеТекст.Видимость = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ВнешнееСобытие(Источник, Событие, Данные)
	
	Если Источник = "AddIn.WindowsControl" И Событие = "MOUSEHOOK" Тогда
		
		ДанныеСобытия = Ванесса.ПрочитатьСтрокуJSON(Данные);
		
		Если ДанныеСобытия.event = "LBUTTONDOWN" Тогда
			
			ТочкаX1 = ДанныеСобытия.x;
			ТочкаY1 = ДанныеСобытия.y;
			
		ИначеЕсли ДанныеСобытия.event = "LBUTTONUP" Тогда
			
			ТочкаX2 = ДанныеСобытия.x;
			ТочкаY2 = ДанныеСобытия.y;
			
			ОбластьXОтрицательная = ((ТочкаX2 - ТочкаX1) < 0);
			ОбластьYОтрицательная = ((ТочкаY2 - ТочкаY1) < 0);
			
			// Линия справа снизу вверх влево.
			Если ОбластьXОтрицательная И ОбластьYОтрицательная Тогда
				ТочкаX = ТочкаX2;
				ТочкаY = ТочкаY2;
				ОбластьWidth = ТочкаX1 - ТочкаX2;
				ОбластьHeight = ТочкаY1 - ТочкаY2;
			// Линия сверху справа вниз влево.
			ИначеЕсли ОбластьXОтрицательная Тогда
				ТочкаX = ТочкаX2;
				ТочкаY = ТочкаY1;
				ОбластьWidth = ТочкаX1 - ТочкаX2;
				ОбластьHeight = ТочкаY2 - ТочкаY1;
			// Линия снизу слева вверх вправо.
			ИначеЕсли ОбластьYОтрицательная Тогда
				ТочкаX = ТочкаX1;
				ТочкаY = ТочкаY2;
				ОбластьWidth = ТочкаX2 - ТочкаX1;
				ОбластьHeight = ТочкаY1 - ТочкаY2;
			// Линия сверху слева вниз вправо.
			Иначе
				ТочкаX = ТочкаX1;
				ТочкаY = ТочкаY1;
				ОбластьWidth = ТочкаX2 - ТочкаX1;
				ОбластьHeight = ТочкаY2 - ТочкаY1;
			КонецЕсли;
			
			Ванесса.ВнешняяКомпонентаДляСкриншотов.МониторингСобытийМыши = Ложь;
			Если Не АктивноОкноТестКлиента Тогда
				ФигураПрямоугольник();
			КонецЕсли;
			
			ДвоичныеДанные = Ванесса.ВнешняяКомпонентаДляСкриншотов.ПолучитьСнимокОбласти(
				ТочкаX, ТочкаY, ОбластьWidth, ОбластьHeight);
			
			Принскрин = ПоместитьВоВременноеХранилище(ДвоичныеДанные, УникальныйИдентификатор);
			ШаблонКонструкции = "#[autodoc.screenarea] %1 %2 %3 %4";
			КонструкцияШага = Ванесса._СтрШаблон(ШаблонКонструкции, ТочкаX, ТочкаY, ОбластьWidth, ОбластьHeight);
			Элементы.ФормаКопироватьКонструкцию.КнопкаПоУмолчанию = Истина;
			
			// Вернемся обратно в инструмент получения снимка.
			Если Ванесса.Объект.ИспользоватьКомпонентуVanessaExt
				И ДескрипторОсновногоОкнаVA <> 0 Тогда
				
				Оповещение = Новый ОписаниеОповещения("ОбработкаПослеНачатьВызовАктивироватьОкно", Ванесса);
				Ванесса.ВнешняяКомпонентаДляСкриншотов.НачатьВызовАктивироватьОкно(Оповещение, ДескрипторОсновногоОкнаVA);
				
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ИнициализацияФормы(ВладелецФормы) Экспорт
	Ванесса = ВладелецФормы;
КонецФункции

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
// Код процедур и функций    

&НаКлиенте
Процедура КонструкцияШагаПрочиеПриИзменении(Элемент)
	
	Элементы.КонструкцияШагаПрочиеТекст.Видимость = Не ПустаяСтрока(КонструкцияШагаПрочие);     
	
	// Установка текста "КонструкцияШагаПрочиеТекст".
	Если ПустаяСтрока(КонструкцияШагаПрочие) Тогда
		КонструкцияШагаПрочиеТекст = "";
	Иначе
		СтрокаШагаПрочие = КонструкцияШагаПрочиеТаблица.НайтиСтроки(Новый Структура("Представление",КонструкцияШагаПрочие))[0];
		ТекстШаблона = СтрокаШагаПрочие.Значение; 
		
		Если Найти(ТекстШаблона, "%4") = 0 Тогда
			КонструкцияШагаПрочиеТекст = СтрШаблон(ТекстШаблона, ТочкаX,ТочкаY);
		Иначе
			КонструкцияШагаПрочиеТекст = СтрШаблон(ТекстШаблона, ТочкаX,ТочкаY,ОбластьWidth,ОбластьHeight);
		КонецЕсли;

	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КонструкцияШагаПрочиеОчистка(Элемент, СтандартнаяОбработка)
	Элементы.КонструкцияШагаПрочиеТекст.Видимость = Ложь;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура МониторингСобытийНачать(Команда)
	
	Если НЕ Ванесса.Объект.ИспользоватьКомпонентуVanessaExt Тогда
		Ванесса.СообщитьПользователю(Ванесса.Локализовать("Необходимо включить использование внешней компоненты VanessaExt."));
		Возврат;
	КонецЕсли;
	
	АктивноОкноТестКлиента = Ложь;
	Если ДескрипторОсновногоОкнаТекущегоКлиентаТестирования <> 0 Тогда
		
		АктивноОкноТестКлиента = Истина;
		Оповещение = Новый ОписаниеОповещения("ОбработкаПослеНачатьВызовАктивироватьОкно", Ванесса);
		Ванесса.ВнешняяКомпонентаДляСкриншотов.НачатьВызовАктивироватьОкно(Оповещение, ДескрипторОсновногоОкнаТекущегоКлиентаТестирования);
		
	КонецЕсли;
	
	Ванесса.ВнешняяКомпонентаДляСкриншотов.МониторингСобытийМыши = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ФигураПрямоугольник()
	
	НастройкиРисования = ПолучитьНастройкиРисования();
	Ванесса.ВнешняяКомпонентаДляСкриншотов.НачатьВызовНарисоватьПрямоугольник(
		Новый ОписаниеОповещения, НастройкиРисования,
		ТочкаX, ТочкаY, ОбластьWidth, ОбластьHeight);
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьНастройкиРисования(ИспользуемКнопки = Ложь)
	
	ВремСтруктура = Новый Структура;
	ВремСтруктура.Вставить("color", 255);
	ВремСтруктура.Вставить("transparency", 254);
	ВремСтруктура.Вставить("duration", 3000);
	ВремСтруктура.Вставить("thickness", 2);
	ВремСтруктура.Вставить("frameDelay", 20);
	ВремСтруктура.Вставить("fontName", "Calibri");
	ВремСтруктура.Вставить("fontSize", 09);
	
	Возврат Ванесса.ЗаписатьОбъектJSON(ВремСтруктура);
	
КонецФункции

&НаКлиенте
Процедура КопироватьКонструкцию(Команда)
	Если Не ПустаяСтрока(КонструкцияШага) Тогда
		Ванесса.ПоместитьВБуферОбменаVA(КонструкцияШага);
		Закрыть();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура КонструкцияШагаПрочиеТаблицаЗаполнение()
	
	//Элементы.КонструкцияШагаПрочие.СписокВыбора.Добавить(  
	НоваяСтрока = КонструкцияШагаПрочиеТаблица.Добавить();
	НоваяСтрока.Значение = "И Я рисую рамку по координатам ""%1"" ""%2"" ""%3"" ""%4""
										|        |'Цвет'      | 'Красный'    |
										|        |'Длительность'  | '2000'       |
										|        |'Прозрачность'   | '127'         |
										|        |'Толщина'     | '2'         |"; 
	НоваяСтрока.Представление = "Отрисовка рамки по координатам ""ТочкаX"" ""ТочкаY"" ""Длина"" ""Ширина""";
	
	НоваяСтрока = КонструкцияШагаПрочиеТаблица.Добавить();
	НоваяСтрока.Значение = "И Я рисую эллипс по координатам ""%1"" ""%2"" ""%3"" ""%4""
										|        |'Цвет'      | 'Красный'    |
										|        |'Длительность'  | '2000'       |
										|        |'Прозрачность'   | '127'         |
										|        |'Толщина'     | '2'         |"; 
	НоваяСтрока.Представление = "Отрисовка эллипса (овала) по координатам ""ТочкаX"" ""ТочкаY"" ""Длина"" ""Ширина""";

	
	НоваяСтрока = КонструкцияШагаПрочиеТаблица.Добавить();
	НоваяСтрока.Значение = "И Я рисую тень по координатам ""%1"" ""%2"" ""%3"" ""%4"" текст надписи ""Текст подсказки""
										|        |'Цвет'      | 'Красный'    |
										|        |'Длительность'  | '2000'       |
										|        |'Прозрачность'   | '127'         |
										|        |'Толщина'     | '2'         |"; 
	НоваяСтрока.Представление = "Отображение затенения прямоугольником по координатам ""ТочкаX"" ""ТочкаY"" ""Длина"" ""Ширина"" с подсказкой в виде текста";
	
	НоваяСтрока = КонструкцияШагаПрочиеТаблица.Добавить();
	НоваяСтрока.Значение = "И Я рисую надпись по точкам ""%1"" ""%2"" текст надписи ""Привет Мир!""
										|        |'ЦветШрифта'      | 'Красный'    |
										|        |'РазмерШрифта'      | '14'    |
										|        |'Длительность'  | '2000'       |
										|        |'Прозрачность'   | '127'         |
										|        |'Толщина'     | '2'         |"; 
	НоваяСтрока.Представление = "Отрисовка надписи цветом на экране в позиции ""ТочкаX"" ""ТочкаX"" текст надписи ""Текст подсказки""";

	НоваяСтрока = КонструкцияШагаПрочиеТаблица.Добавить();
	НоваяСтрока.Значение = "И Я рисую подсказку-балон по точкам ""%1"" ""%2"" текст надписи ""Привет Мир!""
										|        |'ЦветШрифта'      | 'Красный'    |
										|        |'РазмерШрифта'      | '14'    |
										|        |'Длительность'  | '2000'       |
										|        |'Прозрачность'   | '127'         |
										|        |'Толщина'     | '2'         |"; 
	НоваяСтрока.Представление = "Отрисовка подсказки в виде облака с надписью на экране в позиции ""ТочкаX"" ""ТочкаX"" текст надписи ""Текст подсказки""";
	
КонецПроцедуры


#КонецОбласти

#Область ИнициализацияПеременных

#Если Клиент Тогда
	ТочкаX1 = 0;
	ТочкаY1 = 0;
#КонецЕсли

#КонецОбласти