# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "COUNTWIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DENOISEWIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PREWIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.COUNTWIDTH { PARAM_VALUE.COUNTWIDTH } {
	# Procedure called to update COUNTWIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COUNTWIDTH { PARAM_VALUE.COUNTWIDTH } {
	# Procedure called to validate COUNTWIDTH
	return true
}

proc update_PARAM_VALUE.DENOISEWIDTH { PARAM_VALUE.DENOISEWIDTH } {
	# Procedure called to update DENOISEWIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DENOISEWIDTH { PARAM_VALUE.DENOISEWIDTH } {
	# Procedure called to validate DENOISEWIDTH
	return true
}

proc update_PARAM_VALUE.PREWIDTH { PARAM_VALUE.PREWIDTH } {
	# Procedure called to update PREWIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PREWIDTH { PARAM_VALUE.PREWIDTH } {
	# Procedure called to validate PREWIDTH
	return true
}


proc update_MODELPARAM_VALUE.COUNTWIDTH { MODELPARAM_VALUE.COUNTWIDTH PARAM_VALUE.COUNTWIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COUNTWIDTH}] ${MODELPARAM_VALUE.COUNTWIDTH}
}

proc update_MODELPARAM_VALUE.DENOISEWIDTH { MODELPARAM_VALUE.DENOISEWIDTH PARAM_VALUE.DENOISEWIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DENOISEWIDTH}] ${MODELPARAM_VALUE.DENOISEWIDTH}
}

proc update_MODELPARAM_VALUE.PREWIDTH { MODELPARAM_VALUE.PREWIDTH PARAM_VALUE.PREWIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PREWIDTH}] ${MODELPARAM_VALUE.PREWIDTH}
}

