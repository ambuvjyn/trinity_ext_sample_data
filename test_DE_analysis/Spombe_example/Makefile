test:
	${TRINITY_HOME}/Analysis/DifferentialExpression/run_DE_analysis.pl -m Trinity_genes.counts.matrix --method edgeR -s samples.txt --dispersion 0.01 --output edgeR_genes

	cd edgeR_genes && ${TRINITY_HOME}/Analysis/DifferentialExpression/analyze_diff_expr.pl -m ../Trinity_genes.TMM.EXPR.matrix \
        -s ../samples.txt  --examine_GO_enrichment --GO_annots ../Trinotate_report.xls.gene_ontology --gene_lengths ../Trinity_genes.lengths && \
           ${TRINITY_HOME}/Analysis/DifferentialExpression/validate_UP_subset.Rscript ../samples.txt
	./validate_results.pl 
	touch test

clean:
	rm -rf ./edgeR_genes
	rm test
