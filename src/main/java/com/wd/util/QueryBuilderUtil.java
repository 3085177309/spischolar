package com.wd.util;

import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;

import com.wd.front.bo.ConditionInfo;
import com.wd.front.bo.QueryStringInfo;
import com.wd.front.bo.UniqueList;
import com.wd.front.context.FilterStrategyContext;
import com.wd.front.context.QueryStrategyContext;
import com.wd.front.menum.LogicEnum;
import com.wd.front.module.es.strategy.QueryBuilderStrategyI;

/**
 * 将UniqueList转换为QueryBuilder
 * 
 * @author pan
 * 
 */
public class QueryBuilderUtil {

	private static Logger logger = Logger.getLogger(QueryBuilderUtil.class);

	/**
	 * 将UniqueList转换为QueryBuilder
	 * 
	 * @param queryConditionList
	 * @param queryStrategyContext
	 * @return
	 */
	public static QueryBuilder convertQueryBuilder(UniqueList queryConditionList, QueryStrategyContext queryStrategyContext) {
		if (queryConditionList.isEmpty()) {
			return QueryBuilders.matchAllQuery();
		}

		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		for (String queryCondition : queryConditionList) {
			// 获取检索条件中的字段条件
			QueryStringInfo fieldInfo = getStringInfo(queryCondition);
			if (null == fieldInfo) {
                continue;
            }
			// 获取检索条件中的逻辑条件
			QueryStringInfo logicInfo = getStringInfo(fieldInfo.getNewVal());
			if (null == logicInfo) {
                continue;
            }
			// 获取检索条件中的其它条件
			QueryStringInfo otherInfo = getStringInfo(logicInfo.getNewVal());
			if (null == otherInfo) {
                continue;
            }
			// 获取检索条件的检索值条件
			String value = otherInfo.getNewVal().trim().replaceAll("%320", ",").replaceAll("%310", " ");
			if (null == value || "".equals(value)) {
                continue;
            }
			queryConditionList.addConditionInfo(new ConditionInfo(fieldInfo.getSubVal(), value, logicInfo.getSubVal()));
			QueryBuilderStrategyI strategy = queryStrategyContext.getStrategyContext().get(fieldInfo.getSubVal().trim());
			if (null == strategy) {
				if (logger.isDebugEnabled()) {
					logger.debug("无法找到与[" + fieldInfo.getSubVal().trim() + "]对应的QueryBuilderStrategyI实例!");
				}
				continue;
			}
			QueryBuilder queryBuilder = strategy.execute(value, otherInfo.getSubVal());
			if (null == queryBuilder) {
				if (logger.isDebugEnabled()) {
					logger.debug("query策略[" + fieldInfo.getSubVal().trim() + "]，使用检索值[" + value + "]时，执行失败!");
				}
				continue;
			}
			if (LogicEnum.should.value().equals(logicInfo.getSubVal().trim())) {
				boolQueryBuilder.should(queryBuilder);
			} else if (LogicEnum.must_not.value().equals(logicInfo.getSubVal().trim())) {
				boolQueryBuilder.mustNot(queryBuilder);
			} else if(LogicEnum.should_must.value().equals(logicInfo.getSubVal().trim())){
				boolQueryBuilder.should(queryBuilder);
				boolQueryBuilder.minimumShouldMatch(1);//至少匹配一个
			}else {
				boolQueryBuilder.must(queryBuilder);
			}
		}
		return boolQueryBuilder.hasClauses() ? boolQueryBuilder : QueryBuilders.matchAllQuery();
	}

	private static QueryStringInfo getStringInfo(String queryCondition) {
		// 格式：field_logic_other_value
		int pos = 0;
		String field = null;
		pos = queryCondition.indexOf("_");
		if (-1 == pos) {
            return null;
        }
		field = queryCondition.substring(0, pos);
		if (SimpleUtil.strIsNull(field)) {
            return null;
        }
		queryCondition = queryCondition.substring(pos + 1);
		return new QueryStringInfo(queryCondition, field);
	}
}
