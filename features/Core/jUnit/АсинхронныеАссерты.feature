﻿# language: ru
# encoding: utf-8
#parent uf:
@UF11_Прочее
#parent ua:
@UA44_Прочая_активность_по_проверке

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb



Функционал: Проверка асинхронных ассертов



Контекст: 
	Когда Я открываю VanessaAutomation в режиме TestClient со стандартной библиотекой
	
Сценарий: Проверка асинхронных ассертов
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ФичаДляПроверкиАсинхронныхАссертов1"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И я нажимаю на кнопку с именем 'ВыполнитьСценарии'
	Затем я жду, что в сообщениях пользователю будет подстрока "Можно продолжать." в течение 30 секунд
	
	И пауза 1

	И я перехожу к закладке с именем "ГруппаСлужебная"
	И я перехожу к закладке с именем "ГруппаСлужебноеВыполнитьКод"
	И в поле с именем 'РеквизитПроизвольныйКод' я ввожу текст 'Сообщить("БылаОшибка="+ПроверитьРавенство(1, 2, "1 и 2 не равны.").БылаОшибка)'
	
	И я нажимаю на кнопку с именем 'ВыполнитьПроизвольныйКод'
	
	Тогда не появилось окно предупреждения системы
	
	Затем я жду, что в сообщениях пользователю будет подстрока "БылаОшибка=Да" в течение 30 секунд
	
	И в поле с именем 'РеквизитПроизвольныйКод' я ввожу текст 'ПродолжитьВыполнениеШагов()'
	И я нажимаю на кнопку с именем 'ВыполнитьПроизвольныйКод'
	
	//из-за особенностей ранних версий платформы
	Если Версия платформы ">=" "8.3.10" Тогда
			И пауза 2
	
			И в таблице "ДеревоТестов" я разворачиваю строку:
				| 'Наименование'                        |
				| 'ФичаДляПроверкиАсинхронныхАссертов1' |
		
			И в таблице "ДеревоТестов" я сворачиваю строку:
				| 'Наименование'                       |
				| 'И я выполняю код встроенного языка' |

			Тогда таблица "ДеревоТестов" стала равной:
				| 'Наименование'                                                        | 'Статус' |
				| 'ФичаДляПроверкиАсинхронныхАссертов1.feature'                         | ''       |
				| 'ФичаДляПроверкиАсинхронныхАссертов1'                                 | ''       |
				| 'ФичаДляПроверкиАсинхронныхАссертов1'                                 | 'Failed' |
				| 'И я выполняю код встроенного языка'                                  | 'Failed' |
				| 'И Я запоминаю значение выражения \'1\' в переменную "ИмяПеременной"' | ''       |


	