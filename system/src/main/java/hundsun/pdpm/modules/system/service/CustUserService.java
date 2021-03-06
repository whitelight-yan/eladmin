package hundsun.pdpm.modules.system.service;

import hundsun.pdpm.modules.system.domain.CustUser;
import hundsun.pdpm.modules.system.service.dto.CustUserDTO;
import hundsun.pdpm.modules.system.service.dto.CustUserQueryCriteria;
import org.springframework.data.domain.Pageable;
import java.util.Map;
import java.util.List;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;

/**
* @author yantt
* @date 2019-11-30
*/
public interface CustUserService {

    /**
    * 查询数据分页
    * @param criteria 条件参数
    * @param pageable 分页参数
    * @return Map<String,Object>
    */
    Map<String,Object> queryAll(CustUserQueryCriteria criteria, Pageable pageable);

    /**
    * 查询所有数据不分页
    * @param criteria 条件参数
    * @return List<CustUserDTO>
    */
    List<CustUserDTO> queryAll(CustUserQueryCriteria criteria);

    /**
     * 根据ID查询
     * @param id ID
     * @return CustUserDTO
     */
    CustUserDTO findById(Long id);

    CustUserDTO create(CustUser resources);

    void update(CustUser resources);

    void delete(Long id);

    void download(List<CustUserDTO> all, HttpServletResponse response) throws IOException;
}