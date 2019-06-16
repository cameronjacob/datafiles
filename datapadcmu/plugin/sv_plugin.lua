local PLUGIN = PLUGIN;

--Medical Objectives panel
Clockwork.datastream:Hook("EditMedicalObjectives", function(player, data)
	if (player.editObjectivesAuthorised and type(data) == "string") then
		if (Schema.medicalObjectives != data) then
			Schema.medicalObjectives = string.sub(data, 0, 500);
			
			Clockwork.kernel:SaveSchemaData("medicalobjectives", {
				text = Schema.medicalObjectives
			});
		end;
		
		player.editObjectivesAuthorised = nil;
	end;
end);