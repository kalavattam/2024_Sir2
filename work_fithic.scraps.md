
`#work_fithic.scraps.md`
<br />
<br />

```bash
#  Read in functions to modularize the code -----------------------------------
# function create_associative_array() {
#     local help=$(
# cat << EOM
# Usage: create_associative_array associative_array array string
#
# Create an associative array and a regular (integer-indexed from 0) array from a given string.
#
# Positional arguments:
#   associative_array  The name of the associative array to be populated
#   array              The name of the regular array to be populated
#   string             The string containing key-value pairs to populate the arrays
#
# Keyword argument:
#   -h, --help         Display this help message
#
# Example:
#   create_associative_array A_dirs a_dirs "key_1\tvalue_1\nkey_2\tvalue_2"
# EOM
#     )
#
#     if [[ "$#" -ne 3 ]]; then
#         if [[ "${1}" == "-h" || "${1}" == "--help" || "$#" -eq 0 ]]; then
#             echo "${help}"
#             return 0
#         else
#             echo "Error: Three positional arguments were not provided."
#             echo "${help}"
#             return 1
#         fi
#     fi
#
#     local -n _A="${1}"
#     local -n _a="${2}"
#     local key value
#
#     while IFS=$'\t' read -r key value; do
#         _A["${key}"]="${value}"
#         _a+=("${key}")
#     done < <(echo -e "${3}")
#
#     return 0
# }


# function print_associative_array() {
#     local -n _A="${1}"
#     local key
#     local help=$(
# cat << EOM
# Usage: print_associative_array associative_array
#
# Print the keys and values of the given associative array.
#
# Positional argument:
#   associative_array  The name of the associative array to be printed
#
# Keyword argument:
#   -h, --help         Display this help message
#
# Example:
#   print_associative_array A_dirs
# EOM
#     )
#
#     if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
#         echo "${help}"
#         return 0
#     fi
#
#     if [[ "$#" -ne 1 ]]; then
#         echo "Error: A single positional argument was not provided."
#         echo "${help}"
#         return 1
#     fi
#
#     if ! (declare -p "${1}" 2> /dev/null | grep -q 'declare -A'); then
#         echo "Error: The provided variable \"${1}\" is not an associative array."
#         return 1
#     fi
#
#     for key in "${!_A[@]}"; do
#         echo -e "key\t${key}\nvalue\t${_A[$key]}\n"
#     done
#
#     return 0
# }


# function get_file_out() {
#     local help=$(
# cat << EOM
# Usage: get_file_out file_in associative_array array file_out
#
# Get the file_out value based on the file_in and the prefix associative array.
#
# Positional arguments:
#   file_in            The input file name
#   associative_array  The name of the associative array containing prefixes
#   array              The name of the regular array containing keys
#   file_out           The name of the variable to store the output file name
#
# Keyword argument:
#   -h, --help         Display this help message
#
# Example:
#   get_file_out "input.cool" A_prefix a_prefix file_out
# EOM
#     )
#
#     if [[ "$#" -ne 4 || "${1}" == "-h" || "${1}" == "--help" ]]; then
#         echo "${help}"
#         return 0
#     fi
#
#     if [[ "$#" -ne 4 ]]; then
#         echo "Error: Four positional arguments were not provided."
#         echo "${help}"
#         return 1
#     fi
#    
#     local debug=true
#     local key file_in A_prefix
#     local -n _file_out="${4}"
#     typeset -A A_prefix
#
#     [[ ${debug} == true ]] && echo "Debug: file_in=${1}"
#     [[ ${debug} == true ]] && echo "Debug: Entire string to populate array: ${3}"
#     [[ ${debug} == true ]] &&
#         {        
#             # Print each line before reading into key-value pairs
#             while IFS= read -r line; do
#                 [[ ${debug} == true ]] \
#                     && echo "Debug: Line to be split into key-value: ${line}"
#             done < <(echo -e "${3}")
#         }
#
#     IFS=$'\t'
#     while read -r key value; do
#         A_prefix["$key"]="$value"
#         [[ ${debug} == true ]] && echo "Debug: key=${key}, value=${value}"
#     done < <(echo -e "${3}")
#
#     for key in "${!A_prefix[@]}"; do
#         [[ ${debug} == true ]] && echo "Debug: Checking key=${key}"
#        
#         if [[ "${file_in}" =~ "${key}" ]]; then
#             [[ ${debug} == true ]] && echo "Debug: Match found for key=${key}"
#
#             _file_out=$(
#                 echo "${file_in}" \
#                     | sed -E -e 's/.cool/.ia.txt.gz/' \
#                              -e 's:11_cooler:13_FitHiC2:g' \
#                              -e 's:.standard-rDNA-complete.mapped::g' \
#                              -e 's:downsample:ds:g' \
#                              -e "s:$key:${A_prefix[$key]}:g"
#             )
#             break
#             [[ ${debug} == true ]] && echo "Debug: _file_out=${_file_out}"
#         fi
#     done
#
#     return 0
# }
```
