<template>
  <el-dialog :append-to-body="true" :close-on-click-modal="false" :before-close="cancel" :visible.sync="dialog" :title="operate" width="500px">
    <el-form ref="form" :model="form" :rules="rules" size="small" label-width="80px" :disabled="operate==='详情'">
<#if columns??>
  <#list columns as column>
  <#if column.changeColumnName != '${pkChangeColName}'>
      <el-form-item label="<#if column.columnComment != ''>${column.columnComment}<#else>${column.changeColumnName}</#if>"  prop="${column.changeColumnName}">
        <#if column.dictName??>
        <el-select v-model="form.${column.changeColumnName}" filterable  placeholder="请选择">
          <el-option
                  v-for="item in ${column.changeDictName}"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value" ></el-option>
        </el-select>
        <#elseif column.columnType != 'Timestamp'>
        <el-input v-model="form.${column.changeColumnName}" style="width: 370px;"/>
        <#else>
        <el-date-picker v-model="form.${column.changeColumnName}" type="datetime" style="width: 370px;"/>
        </#if>
      </el-form-item>
  </#if>
  </#list>
</#if>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button type="text" @click="cancel">取消</el-button>
      <el-button v-if="operate!=='详情'" :loading="loading" type="primary" @click="doSubmit">确认</el-button>
    </div>
  </el-dialog>
</template>

<script>
import { add, edit } from '@/api/${changeClassName}'
export default {
  props: {
    operate: {
      type: String,
      required: true
    }
    <#if columns??>
    <#list columns as column>
      <#if column.changeDictName??>
   ,${column.changeDictName}: {
     type: Array,
     required: true
    }
      </#if>
    </#list>
    </#if>
  },
  data() {
    return {
      loading: false, dialog: false,
      form: {
<#if columns??>
    <#list columns as column>
        ${column.changeColumnName}: ''<#if column_has_next>,</#if>
    </#list>
</#if>
      },
      rules: {
<#list columns as column>
<#if column.columnKey = 'UNI'>
        ${column.changeColumnName}: [
          { required: true, message: 'please enter', trigger: 'blur' }
        ]<#if (column_has_next)>,</#if>
<#elseif column.isNullable=='No'>
        ${column.changeColumnName}: [
          { required: true, message: <#if column.columnComment != ''>'${column.columnComment}'<#else>'${column.changeColumnName}'</#if>, trigger: 'blur' }
        ]<#if (column_has_next)>,</#if>
</#if>
</#list>
      }
    }
  },
  methods: {
    cancel() {
      this.resetForm()
    },
    doSubmit() {
      this.$refs.form.validate((vaild)=>{
          if(vaild) {
            this.loading = true
            if (this.operate ==='新增') {
              this.doAdd();
            } else if(this.operate ==='修改'){
              this.doEdit();
            }
          }
        })

    },
    doAdd() {
      add(this.form).then(res => {
        this.resetForm()
        this.$notify({
          title: '添加成功',
          type: 'success',
          duration: 2500
        })
        this.loading = false
        this.$parent.init()
      }).catch(err => {
        this.loading = false
        console.log(err.response.data.message)
      })
    },
    doEdit() {
      edit(this.form).then(res => {
        this.resetForm()
        this.$notify({
          title: '修改成功',
          type: 'success',
          duration: 2500
        })
        this.loading = false
        this.$parent.init()
      }).catch(err => {
        this.loading = false
        console.log(err.response.data.message)
      })
    },
    resetForm() {
      this.dialog = false
      this.$refs['form'].resetFields()
      this.form = {
<#if columns??>
    <#list columns as column>
        ${column.changeColumnName}: ''<#if column_has_next>,</#if>
    </#list>
</#if>
      }
    }
  }
}
</script>

<style scoped>

</style>
