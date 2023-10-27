#!/bin/bash

[[ -f test.G1.ia.txt ]] && rm test.G1.ia.txt


Condition 1: Column 1 OR column 3 must be "XII"
Condition 2: If column 1 AND column 3 are both "XII", { { column 2 must be less than 451400 OR greater than 469200 } AND { column 4 must be less than 451400 OR greater than 469200 } }
Condition 3: If column 1 is "XII" AND column 3 is NOT "XII", column 3 must be one the following: { I II III IV V VI VII VIII IX X XI XIII XIV XV XVI }
Condition 4: If column 3 is "XII" AND column 1 is NOT "XII", column 1 must be one the following: { I II III IV V VI VII VIII IX X XI XIII XIV XV XVI }

[[ -f test.G1.ia.txt ]] && rm test.G1.ia.txt
cat G1.1600.ds-to-Q.XII-all.ia.txt \
    | awk -F '\t' '{
        if (($1 == "XII" || $3 == "XII") && !(($1 == "XII" && $3 == "XII" && ($2 >= 451400 && $2 <= 469200) && ($4 >= 451400 && $4 <= 469200)) || ($1 == "XII" && $3 != "XII" && ($3 ~ /^(I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XIII|XIV|XV|XVI)$/)) || ($3 == "XII" && $1 != "XII" && ($1 ~ /^(I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XIII|XIV|XV|XVI)$/)) ) ) { print $0 }
    }' \
    > test.G1.ia.txt


cat G1.1600.ds-to-Q.XII-all.ia.txt \
    | awk -F '\t' '{
        if (($1 == "XII" || $3 == "XII")) { print $0 }
    }'

awk -F '\t' '{
        if (($1 == "XII" || $3 == "XII") && !(($1 == "XII" && $3 == "XII" && ($2 >= 451400 && $2 <= 469200) && ($4 >= 451400 && $4 <= 469200)) || ($1 == "XII" && $3 != "XII" && ($3 ~ /^(I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XIII|XIV|XV|XVI)$/)) || ($3 == "XII" && $1 != "XII" && ($1 ~ /^(I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XIII|XIV|XV|XVI)$/)) ) ) { print $0 }
    }'

[[ -f test.G1.ia.txt ]] && rm test.G1.ia.txt
cat G1.1600.ds-to-Q.XII-all.ia.txt | awk -F '\t' '{
    if (!((($1 == "XII" || $3 == "XII") &&
          (!($1 == "XII" && $3 == "XII") || ($2 < 451400 || $2 > 469200) || ($4 < 451400 || $4 > 469200)) &&
          (!($1 == "XII" && $3 != "XII") || ($3 ~ /^(I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XIII|XIV|XV|XVI)$/)) &&
          (!($3 == "XII" && $1 != "XII") || ($1 ~ /^(I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XIII|XIV|XV|XVI)$/)) &&
          ($1 != "Mito" && $3 != "Mito"))) {
        print $0
    }
}' > test.G1.ia.txt

[[ -f test.cond-1.txt ]] && rm test.cond-1.txt
cat G1.1600.ds-to-Q.XII-all.ia.txt \
    | awk -F '\t' '{
        if (($1 == "XII" || $3 == "XII")) { print $0 }
    }' \
        > test.cond-1.txt

cat G1.1600.ds-to-Q.XII-all.ia.txt \
    | awk -F '\t' '{
            if (($1 == "XII" || $3 == "XII")) { print $0 }
        }' \
    | awk -F '\t' '{
        if (( $1 != "Mito" && $3 != "Mito" )) { print $0 }
    }' \
        > test.cond-2.txt

[[ -f test.cond-4.txt ]] && rm test.cond-4.txt
cat G1.1600.ds-to-Q.XII-all.ia.txt \
    | awk -F '\t' '{
            if (($1 == "XII" || $3 == "XII")) { print $0 }
        }' \
    | awk -F '\t' '{
        if (( $1 != "Mito" && $3 != "Mito" )) { print $0 }
    }' \
    | awk -F '\t' '{
        if (($1 == "XII" && $3 == "XII") && ($2 >= 451400 && $2 <= 469200) || ($4 >= 451400 && $4 <= 469200)) { print $0 }
    }' \
    | awk -F '\t' '{
        if (($1 == "XII" && $3 == "XII") && ($2 >= 451400 && $2 <= 469200) && ($4 >= 451400 && $4 <= 469200)) { print $0 }
    }' \
        > test.cond-4.txt


# if (($1 == "XII" && $3 == "XII") && (($2 >= 451400 && $2 <= 469200) || ($4 >= 451400 && $4 <= 469200)))

awk -F '\t' '{
  if (($1 == "XII" || $3 == "XII") &&
      !(($1 == "XII" && $3 == "XII") &&
        (($2 < 451400 || $2 > 469200) ||
         ($4 < 451400 || $4 > 469200))) &&
      !(($1 == "XII" && $3 !~ /^(I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XIII|XIV|XV|XVI)$/)) &&
      !(($3 == "XII" && $1 !~ /^(I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XIII|XIV|XV|XVI)$/)))
    print
}' G1.1600.ds-to-Q.XII-all.ia.txt > filtered_file.txt

[[ -f filtered_file.txt ]] && rm filtered_file.txt
awk -F'\t' '{
  if (!($1 == "XII" && $3 == "XII" && $2 >= 451400 && $2 <= 469200) &&
      !($1 == "XII" && $3 == "XII" && $4 >= 451400 && $4 <= 469200) &&
      !($1 == "XII" && $3 == "Mito") &&
      !($3 == "XII" && $1 == "XII" && $2 >= 451400 && $2 <= 469200) &&
      !($3 == "XII" && $1 == "XII" && $4 >= 451400 && $4 <= 469200))
    print
}' G1.1600.ds-to-Q.XII-all.ia.txt > filtered_file.txt


#USE #GOOD
cat G1.1600.ds-to-Q.XII-all.ia.txt \
    | awk -F'\t' '{
  if ((($1 == "XII" && $2 >= 451400 && $2 <= 469200) && ($3 != "XII" || ($3 == "XII" && ($4 < 451400 || $4 > 469200)))) ||
      (($3 == "XII" && $4 >= 451400 && $4 <= 469200) && ($1 != "XII" || ($1 == "XII" && ($2 < 451400 || $2 > 469200)))))
    print
}' \
    > filtered_file.txt


cat G1.1600.ds-to-Q.XII-all.ia.txt \
    | awk -F '\t' '{
        if (( $1 != "Mito" && $3 != "Mito" )) { print $0 }
    }' \
        > test.G1.ia.txt
