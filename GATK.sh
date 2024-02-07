#!/bin/bash/

echo "Indexing..."
tabix -p vcf equus_caballus3.vcf
samtools faidx Equus_caballus.EquCab3.0.dna.toplevel.fa
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar CreateSequenceDictionary -R Equus_caballus.EquCab3.0.dna.toplevel.fa

echo "READ GROUP ADDING..."
echo "SAMPLE 1"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/After_1.bam -O samples3/RGA1.bam -RGID 1 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/Before_1.bam -O samples3/RGB1.bam -RGID 1 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20

echo "SAMPLE 2"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/After_2.bam -O samples3/RGA2.bam -RGID 2 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/Before_2.bam -O samples3/RGB2.bam -RGID 2 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20

echo "SAMPLE 3"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/After_3.bam -O samples3/RGA3.bam -RGID 3 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/Before_3.bam -O samples3/RGB3.bam -RGID 3 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20

echo "SAMPLE 4"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/After_4.bam -O samples3/RGA4.bam -RGID 4 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/Before_4.bam -O samples3/RGB4.bam -RGID 4 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20

echo "SAMPLE 6"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/After_6.bam -O samples3/RGA6.bam -RGID 6 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar AddOrReplaceReadGroups -I samples3/Before_6.bam -O samples3/RGB6.bam -RGID 6 -RGLB lib1 -RGPL illumina -RGPU unit1 -RGSM 20


echo "SORTING BY COORDINATES..."
echo "SAMPLE 2"

java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGA2.bam -O samples3/sorted_A2.bam --CREATE_INDEX true -SO coordinate 
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGB2.bam -O samples3/sorted_B2.bam --CREATE_INDEX true -SO coordinate 
echo "SAMPLE 1"
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGA1.bam -O samples3/sorted_A1.bam --CREATE_INDEX true -SO coordinate 
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGB1.bam -O samples3/sorted_B1.bam --CREATE_INDEX true -SO coordinate 

echo "SAMPLE 3"
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGA3.bam -O samples3/sorted_A3.bam --CREATE_INDEX true -SO coordinate 
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGB3.bam -O samples3/sorted_B3.bam --CREATE_INDEX true -SO coordinate 

echo "SAMPLE 4"
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGA4.bam -O samples3/sorted_A4.bam --CREATE_INDEX true -SO coordinate 
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGB4.bam -O samples3/sorted_B4.bam --CREATE_INDEX true -SO coordinate 

echo "SAMPLE 6"
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGA6.bam -O samples3/sorted_A6.bam --CREATE_INDEX true -SO coordinate 
java -Djava.io.tmpdir=tmp -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SortSam -I samples3/RGB6.bam -O samples3/sorted_B6.bam --CREATE_INDEX true -SO coordinate 

echo "MARKING DUPLICATES..."
echo "SAMPLE 2"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_A2.bam -O samples3/marked_A2.bam --CREATE_INDEX true -M samples3/metrics_A2.txt
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_B2.bam -O samples3/marked_B2.bam --CREATE_INDEX true -M samples3/metrics_B2.txt

echo "SAMPLE 1"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_A1.bam -O samples3/marked_A1.bam --CREATE_INDEX true -M samples3/metrics_A1.txt
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_B1.bam -O samples3/marked_B1.bam --CREATE_INDEX true -M samples3/metrics_B1.txt


echo "SAMPLE 6"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_A6.bam -O samples3/marked_A6.bam --CREATE_INDEX true -M samples3/metrics_A6.txt
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_B6.bam -O samples3/marked_B6.bam --CREATE_INDEX true -M samples3/metrics_B6.txt


echo "SAMPLE 3"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_A3.bam -O samples3/marked_A3.bam --CREATE_INDEX true -M samples3/metrics_A3.txt
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_B3.bam -O samples3/marked_B3.bam --CREATE_INDEX true -M samples3/metrics_B3.txt

echo "SAMPLE 4"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_A4.bam -O samples3/marked_A4.bam --CREATE_INDEX true -M samples3/metrics_A4.txt
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar MarkDuplicates -I samples3/sorted_B4.bam -O samples3/marked_B4.bam --CREATE_INDEX true -M samples3/metrics_B4.txt



echo "HAPLOTYPE CALLER... "
echo "SAMPLE 1"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_A1.bam -O output3/sample_1/sample_A1_gvcf.g.vcf.gz -ERC GVCF
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_B1.bam -O output3/sample_1/sample_B1_gvcf.g.vcf.gz -ERC GVCF

echo "SAMPLE 2"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_A2.bam -O output3/sample_2/sample_A2_gvcf.g.vcf.gz -ERC GVCF
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_B2.bam -O output3/sample_2/sample_B2_gvcf.g.vcf.gz -ERC GVCF

echo "SAMPLE 3"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_A3.bam -O output3/sample_3/sample_A3_gvcf.g.vcf.gz -ERC GVCF
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_B3.bam -O output3/sample_3/sample_B3_gvcf.g.vcf.gz -ERC GVCF

echo "SAMPLE 4"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_A4.bam -O output3/sample_4/sample_A4_gvcf.g.vcf.gz -ERC GVCF
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_B4.bam -O output3/sample_4/sample_B4_gvcf.g.vcf.gz -ERC GVCF

echo "SAMPLE 6"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_A6.bam -O output3/sample_6/sample_A6_gvcf.g.vcf.gz -ERC GVCF
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar HaplotypeCaller -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -I samples3/marked_B6.bam -O output3/sample_6/sample_B6_gvcf.g.vcf.gz -ERC GVCF

 echo "GENOTYPE CALLER..."
 echo "SAMPLE 1"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_1/sample_A1_gvcf.g.vcf.gz -O output3/sample_1/sample_A1_raw.vcf.gz
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_1/sample_B1_gvcf.g.vcf.gz -O output3/sample_1/sample_B1_raw.vcf.gz

echo "SAMPLE 2"
java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_2/sample_A2_gvcf.g.vcf.gz -O output3/sample_2/sample_A2_raw.vcf.gz
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_2/sample_B2_gvcf.g.vcf.gz -O output3/sample_2/sample_B2_raw.vcf.gz

echo "SAMPLE 3"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_3/sample_A3_gvcf.g.vcf.gz -O output3/sample_3/sample_A3_raw.vcf.gz
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_3/sample_B3_gvcf.g.vcf.gz -O output3/sample_3/sample_B3_raw.vcf.gz

echo "SAMPLE 4"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_4/sample_A4_gvcf.g.vcf.gz -O output3/sample_4/sample_A4_raw.vcf.gz
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_4/sample_B4_gvcf.g.vcf.gz -O output3/sample_4/sample_B4_raw.vcf.gz

echo "SAMPLE 6"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_6/sample_A6_gvcf.g.vcf.gz -O output3/sample_6/sample_A6_raw.vcf.gz
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar GenotypeGVCFs -R Equus_caballus.EquCab3.0.dna.toplevel.fa -D equus_caballus3.vcf -V output3/sample_6/sample_B6_gvcf.g.vcf.gz -O output3/sample_6/sample_B6_raw.vcf.gz

 echo "SELECTING SNP..."
 echo "SAMPLE 1"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_1/sample_A1_raw.vcf.gz --select-type-to-include SNP -O output3/sample_1/sample_A1_SNP.vcf.gz
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_1/sample_B1_raw.vcf.gz --select-type-to-include SNP -O output3/sample_1/sample_B1_SNP.vcf.gz

echo "SAMPLE 2"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_2/sample_A2_raw.vcf.gz --select-type-to-include SNP -O output3/sample_2/sample_A2_SNP.vcf.gz
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_2/sample_B2_raw.vcf.gz --select-type-to-include SNP -O output3/sample_2/sample_B2_SNP.vcf.gz

echo "SAMPLE 3"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_3/sample_A3_raw.vcf.gz --select-type-to-include SNP -O output3/sample_3/sample_A3_SNP.vcf.gz
java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_3/sample_B3_raw.vcf.gz --select-type-to-include SNP -O output3/sample_3/sample_B3_SNP.vcf.gz

echo "SAMPLE 4"
 java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_4/sample_A3_raw.vcf.gz --select-type-to-include SNP -O output3/sample_4/sample_A3_SNP.vcf.gz
java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_4/sample_B3_raw.vcf.gz --select-type-to-include SNP -O output3/sample_4/sample_B3_SNP.vcf.gz

echo "SAMPLE 6"
 #java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_6/sample_A6_raw.vcf.gz --select-type-to-include SNP -O output3/sample_6/sample_A6_SNP.vcf.gz
 #java -Xmx4g -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar SelectVariants -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_6/sample_B6_raw.vcf.gz --select-type-to-include SNP -O output3/sample_6/sample_B6_SNP.vcf.gz

 echo "FILTERING..."
 echo "SAMPLE 1"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_1/sample_A1_SNP.vcf.gz -O output3/sample_1/sample_A1_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_1/sample_B1_SNP.vcf.gz -O output3/sample_1/sample_B1_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"

echo "SAMPLE 2"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_2/sample_A2_SNP.vcf.gz -O output3/sample_2/sample_A2_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_2/sample_B2_SNP.vcf.gz -O output3/sample_2/sample_B2_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"

echo "SAMPLE 3"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_3/sample_A3_SNP.vcf.gz -O output3/sample_3/sample_A3_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_3/sample_B3_SNP.vcf.gz -O output3/sample_3/sample_B3_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"

echo "SAMPLE 4"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_4/sample_A4_SNP.vcf.gz -O output3/sample_4/sample_A4_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_4/sample_B4_SNP.vcf.gz -O output3/sample_4/sample_B4_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"

echo "SAMPLE 6"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_6/sample_A6_SNP.vcf.gz -O output3/sample_6/sample_A6_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"
java -jar gatk-4.1.6.0/gatk-package-4.1.6.0-local.jar VariantFiltration -R Equus_caballus.EquCab3.0.dna.toplevel.fa -V output3/sample_6/sample_B6_SNP.vcf.gz -O output3/sample_6/sample_B6_filtered.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 4.0" --filter-name "SNPbasic"

#### FS -> to detect strand bias (they look at the allele aa aya strand bel horse w b shoufo aa aya strand it is bel reference genome )!!!FS greater than 60, we still keep many false positive variants. If we move the threshold to a lower value, we risk losing true positive variants
### Ranksum test is used to detect eza fi bias at a position kamen , The ideal result is a value close to zero,Conversely, a positive value indicates that the reference allele is found at the ends of reads more often than the alternate allele.
pmset sleepnow
