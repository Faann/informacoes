-- [[ ♥ Faany ♥ GoldenRP.com.br ♥ ]] --
-- [[ Reconfigurado, restruturado e personalizado ]] --
-- [[Primeira configuração de: Famed ]] --

local format2 = true   -- Formato 24 Horas
local TextoString = nil
local Hora
local Minuto
local DiaDaSemana
local MES
local DiaDoMes
local ANO
local NomeDaRua = {}
local opacidade = 150

NomeDaRua.position = {x = 0.842, y = 0.972, centered = false}

function drawText( str, x, y, style )
	SetTextCentre( false )
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.35, 0.35)
	SetTextColour(255, 215, 0, opacidade+50)
 	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextWrap(0,0.95)
	SetTextEntry("STRING")
	AddTextComponentString(str)
	DrawText( x, y )
end

Citizen.CreateThread(function()
	while true do
		Wait(1)
		TextoString = ""
		CalculateTimeToDisplay()
		CalculateDayOfWeekToDisplay()
		CalculateDateToDisplay()
		TextoString = "HOJE É ".. DiaDaSemana ..", ".. DiaDoMes .." DE " .. MES .. " - " .. Hora .. ":" .. Minuto .. " \nVOCÊ ESTÁ EM"
		SetTextFont(4)
		SetTextProportional(1)
		SetTextScale(0.35, 0.35)
		SetTextColour(255, 255, 255, opacidade)
 		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextWrap(0,0.95)
		SetTextEntry("STRING")
		AddTextComponentString(TextoString)
		DrawText(0.800, 0.952)
	end
end)

function CalculateTimeToDisplay()
	Hora = GetClockHours()
	Minuto = GetClockMinutes()

	if format2 == false then
		if Hora == 0 or Hora == 24 then
			Hora = 12
		elseif Hora >= 13 then
			Hora = Hora - 12
		end
	end

	if Hora <= 9 then
		Hora = "0" .. Hora
	end
	if Minuto <= 9 then
		Minuto = "0" .. Minuto
	end
end

function CalculateDayOfWeekToDisplay()
	DiaDaSemana = GetClockDayOfWeek()
	
	if DiaDaSemana == 0 then
		DiaDaSemana = "DOMINGO"
	elseif DiaDaSemana == 1 then
		DiaDaSemana = "SEGUNDA-FEIRA"
	elseif DiaDaSemana == 2 then
		DiaDaSemana = "TERÇA-FEIRA"
	elseif DiaDaSemana == 3 then
		DiaDaSemana = "QUARTA-FEIRA"
	elseif DiaDaSemana == 4 then
		DiaDaSemana = "QUINTA-FEIRA"
	elseif DiaDaSemana == 5 then
		DiaDaSemana = "SEXTA-FEIRA"
	elseif DiaDaSemana == 6 then
		DiaDaSemana = "SÁBADO"
	end
end

function CalculateDateToDisplay()
	MES = GetClockMonth()
	DiaDoMes = GetClockDayOfMonth()
	ANO = GetClockYear()
	
	if MES == 0 then
		MES = "JANEIRO"
	elseif MES == 1 then
		MES = "FEVEREIRO"
	elseif MES == 2 then
		MES = "MARÇO"
	elseif MES == 3 then
		MES = "ABRIL"
	elseif MES == 4 then
		MES = "MAIO"
	elseif MES == 5 then
		MES = "JUNHO"
	elseif MES == 6 then
		MES = "JULHO"
	elseif MES == 7 then
		MES = "AGOSTO"
	elseif MES == 8 then
		MES = "SETEMBRO"
	elseif MES == 9 then
		MES = "OUTUBRO"
	elseif MES == 10 then
		MES = "NOVEMBRO"
	elseif MES == 11 then
		MES = "DEZEMBRO"
	end

	if DiaDoMes <= 9 then
		DiaDoMes = "0" .. DiaDoMes
	end
end

Citizen.CreateThread( function()
	local UltimaRUA1 = 0
	local lastNomeDaRua = {}
	while true do
		Wait( 0 )
		local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
		local RUA1, RUA2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
		local RUA = {}

		if not ((RUA1 == UltimaRUA1 or RUA1 == UltimaRUA2) and (RUA2 == UltimaRUA1 or RUA2 == UltimaRUA2)) then
			UltimaRUA1 = RUA1
		end

		if UltimaRUA1 ~= 0 then
			table.insert( RUA, GetStreetNameFromHashKey( UltimaRUA1 ) )
		end

		drawText( table.concat( RUA, " & " ), NomeDaRua.position.x, NomeDaRua.position.y, {
			size = NomeDaRua.textSize,
			colour = NomeDaRua.textColour,
			outline = true,
			centered = NomeDaRua.position.centered
		})
	end
end)