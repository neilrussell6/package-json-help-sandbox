#------------------------------
# vars
#------------------------------

# file
FILE		= package.json
FILE_JSON 	= `cat $(FILE)`

# colors
BLACK			= 235
LIME			= 106
RESET 			= "\033[0m"
FG 				= "\033[38;5;$(1)m"
FGB				= "\033[1;38;5;$(1)m"
BG 				= "\033[48;5;$(1)m"

#------------------------------
# functions
#------------------------------

define print_heading
	@$(eval COLOR=$($(or $(1),106)))
	@printf '%b%b %s %b\n' $(call BG,$(BLACK)) $(call FGB,$(COLOR)) $(2) $(RESET)
endef

#------------------------------
# rules
#------------------------------

.PHONY: target
target:
	@$(call print_heading,LIME,"available commands ...")
	@if hash jq 2>/dev/null; then\
		echo $(FILE_JSON) | jq '.scripts | to_entries[] | .key | " - npm run " + select(test("^(?!help)"))' -r;\
	else\
		echo '  JQ is required please run:';\
		echo '	sudo apt install jq';\
	fi

.PHONY: help
help: target
