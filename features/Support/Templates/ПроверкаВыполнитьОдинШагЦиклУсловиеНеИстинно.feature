﻿# language: ru

@IgnoreOnCIMainBuild
@tree


Функционал: Загрузить фичу в vanessa-behavior
	Как Разработчик
	Я Хочу чтобы чтобы у меня была возможность выполнить один шаг условия
 

Сценарий: Загрузка тестовой фичи проверка работы до брейкпоинта
	
	Дано  Я запоминаю значение выражения "1" в переменную "Количество"
	Когда Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 1
	И Пока выражение встроенного языка "Контекст.Количество < 0" истинно тогда
		И     Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 10
		И     Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 10
		И     Я запоминаю значение выражения "Контекст.Количество + 10" в переменную "Количество"
	И     Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 1
	И     Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 1
	И     Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 1
	И     Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 1
	И     Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 1
	И     Я увеличил значение "СлужебныйПараметр" в КонтекстСохраняемый на 1
