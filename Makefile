# author: Jordan Bourak & Tiffany Timbers
# date: 2021-11-22

# all: results/horse_pop_plot_largest_sd.png \
# 	results/horse_pops_plot.png \
# 	results/horses_spread.csv \
# 	reports/qmd_example.html \
# 	reports/qmd_example.pdf

# all: results/horse_pop_plot_largest_sd.png \
# 	results/horse_pops_plot.png \
# 	results/horses_spread.csv \
# 	docs/index.html \
# 	reports/qmd_example.pdf

all: results/horse_pop_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_spread.csv \
	docs/index.html \
	docs/index.pdf

# generate figures and objects for report
results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_spread.csv: source/generate_figures.py
	python source/generate_figures.py --input_dir="data/00030067-eng.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF
reports/qmd_example.html: results reports/qmd_example.qmd
	quarto render reports/qmd_example.qmd --to html

# reports/qmd_example.pdf: results reports/qmd_example.qmd
# 	quarto render reports/qmd_example.qmd --to pdf

docs/index.html: results reports/qmd_example.qmd
	quarto render reports/qmd_example.qmd --to html --output-dir docs --output index.html

docs/index.pdf: report.qmd
	quarto render report.qmd --to pdf --output-dir docs

# clean
clean:
	rm -rf results
	rm -rf docs
	rm -rf reports/qmd_example.html \
		reports/qmd_example.pdf \
		reports/qmd_example_files
