package com.wd.front.menum;

public enum SearchServiceStrategyEnum {

	/**
	 * 快速检索
	 */
	quick_search {
		@Override
		public String value() {
			return "0";
		}
	},
	/**
	 * 高级检索
	 */
	advance_search {
		@Override
		public String value() {
			return "1";
		}
	},
	/**
	 * 专业检索
	 */
	professional_search {
		@Override
		public String value() {
			return "2";
		}
	},
	/**
	 * 分面检索
	 */
	facet_search {
		@Override
		public String value() {
			return "3";
		}
	},
	id_search {

		@Override
		public String value() {
			return "4";
		}

	};

	public abstract String value();
}
