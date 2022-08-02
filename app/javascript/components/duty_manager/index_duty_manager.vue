<template>
  <section class="b-tooltips">
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px;">
      <h1>Personas asociada a la facultad</h1>
      <b-tabs>
        <b-tab-item>
          <div class="has-text-right">
            <b-button label="Añadir Persona asociada" type="is-info" icon-left="plus" @click="createDutyManager()">
            </b-button>
          </div>
         
         <div>
            <b-modal :active="isModalActiveShow" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <show-duty-manager modal-cancel="true" :id="selected" :modal-header="'Detalle de la personaasociada'"
                  @close="closeModalShow"></show-duty-manager>
              </template>
            </b-modal>

            <b-modal :active="isModalActive" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <new-duty-manager modal-cancel="true" :modal-header="'Registro de Persona asociada'" query-type="create"
                  @close="closeModalCreate"></new-duty-manager>
              </template>
            </b-modal>
          </div>


          <div class="column">
            <b-table :data="managers" :paginated=true per-page="8" striped hoverable :pagination-simple=false
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up" sort-icon-size="is-small"
              default-sort="inventores.name" aria-next-label="Siguiente" aria-previous-label="Anterior"
              aria-page-label="Página" aria-current-label="Página actual">

              <b-table-column :visible=false field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>



              </b-table-column>

              <b-table-column field="name_duty_manager" label="Nombre del Peronal" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowdutymanager(props.row.id)">{{ props.row.name_duty_manager }}</a>
                </template>
              </b-table-column>

              <b-table-column field="rut" label="Rut" sortable searchable>

                <template v-slot="props">
                  {{ props.row.rut }}
                </template>
              </b-table-column>

              <b-table-column field="unit.name_unit" label="Nombre Unidad" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowunit(props.row.unit_id)">{{ props.row.unit.name_unit }}</a>
                </template>
              </b-table-column>



              <b-table-column field="id" width="10" v-slot="props">
                <b-tooltip label="Ver detalle" type="is-info">
                  <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowdutymanager(props.row.id)" />
                </b-tooltip>
              </b-table-column>

            </b-table>
          </div>
        </b-tab-item>
      </b-tabs>
    </div>
  </section>
</template>


<script>
import axios from "axios";
import NewDutyManager from './new_duty_manager.vue';
import ShowDutyManager from './show_duty_manager.vue';
export default {
  components: { NewDutyManager, ShowDutyManager },
  data() {
    return {
      managers: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      selected: null,
    };
  },

  methods: {
    async getdutymanager() {
      const response = await axios.get("http://localhost:3000/duty_managers.json");
      this.managers = response.data;
    },
    async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
    async Clicknewdutymanager() {
      const response = (window.location.href = "/duty_managers/new");
    },
    async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item);
    },
    async createDutyManager() {
      this.isModalActive = true;
    },
    async closeModalCreate() {
      this.isModalActive = false;
    },
    async ShowModaleDutyManager(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },

  },
  created() {
    this.getdutymanager();
  },
};
</script>