module CompanyHelper
	def display_city_and_state(company)
		"#{company.city || 'City'}, #{company.state || 'State'}"
	end
end
