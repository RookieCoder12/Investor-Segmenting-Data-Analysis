-- Active: 1760248959323@@localhost@5432@InvestorSegmentation
Select * From info_tb Limit 10;
Select * From info_tb_sec Limit 10;

-- Average Asset Value and Average Loan Amount for different risk rating
SELECT
	"Risk Rating",
	ROUND(
		AVG("Loan Amount") OVER (
			PARTITION BY
				"Risk Rating"
		),
		2
	) AS AVG_LOAN_AMOUNT,
	ROUND(
		AVG("Assets Value") OVER (
			PARTITION BY
				"Risk Rating"
		),
		2
	) AS AVG_AVAL_AMOUNT
FROM
	INFO_TB_SEC;

-- Average of financial for each Label
SELECT DISTINCT
	"Label",
	AVG("Income") OVER (
		PARTITION BY
			"Label"
	) AS AVG_INCOME,
	AVG("Credit Score") OVER (
		PARTITION BY
			"Label"
	) AS AVG_CREDITSCORE,
	AVG("Years at Current Job") OVER (
		PARTITION BY
			"Label"
	) AS AVG_YATJ,
	AVG("Debt-to-Income Ratio") OVER (
		PARTITION BY
			"Label"
	) AS AVG_DBI,
	AVG("Assets Value") OVER (
		PARTITION BY
			"Label"
	) AS AVG_ASSETVAL,
	AVG("Loan Amount") OVER (
		PARTITION BY
			"Label"
	) AS AVG_LOANAMT,
	AVG("Previous Defaults") OVER (
		PARTITION BY
			"Label"
	) AS AVG_PREVDEFAULTS
FROM
	INFO_TB_SEC;

-- Sums up loan amount, assets value, and previous defaults for each distinct loan purpose
Select * 
From
(Select Distinct "Loan Purpose"
	, Sum("Loan Amount")Over(Partition By "Loan Purpose") sum_loanAmt
	, Sum("Assets Value")Over(Partition By "Loan Purpose") sum_AssetVal
	, Sum("Previous Defaults")Over(Partition By "Loan Purpose") sum_PrevDef
From info_tb_sec);