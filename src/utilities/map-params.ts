interface MapParamsReturn extends Record<any, any> {
  page: number;
  pageSize: number;
}

export const mapQueryParams = (params: Record<any, any>): MapParamsReturn => {
  const { page, pageSize = "10", ...others } = params;

  const p = isNaN(+page) ? 1 : +page;
  const pS = isNaN(+pageSize) ? 10 : +pageSize;

  return {
    page: p,
    pageSize: pS,
    ...others,
  };
};
