<template>
  <div id="app" class="container">
    <div class="row">
      <div class="col-md-12">
        <h1>Personas</h1>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <formulario-persona @add-persona="agregarPersona" />
        <!-- <<<<<< -->
        <tabla-personas
          :personas="personas"
          @delete-persona="eliminarPersona"
          @actualizar-persona="actualizarPersona"
        />
      </div>
    </div>
  </div>
</template>

<script>
import TablaPersonas from "@/components/TablaPersonas.vue";
import FormularioPersona from "@/components/FormularioPersona.vue"; // <<<<<<

const rest = import.meta.env.VITE_DJANGOURL;

export default {
  name: "app",
  components: {
    TablaPersonas,
    FormularioPersona,
  },
  data() {
    return {
      personas: [],
    };
  },
  methods: {
    async listadoPersonas() {
      try {
        const response = await fetch(
          import.meta.env.VITE_DJANGOURL + '/api/v1/personas/'
        );
        this.personas = await response.json();
      } catch (error) {
        console.error(error);
      }
    },
    async agregarPersona(persona) {
      try {
        const response = await fetch(
          import.meta.env.VITE_DJANGOURL + '/api/v1/personas/',
          {
            method: "POST",
            body: JSON.stringify(persona),
            headers: { "Content-type": "application/json; charset=UTF-8" },
          }
        );
        const personaCreada = await response.json();
        this.personas = [...this.personas, personaCreada];
      } catch (error) {
        console.error(error);
      }
    },
    async eliminarPersona(persona_id) {
      try {
        await fetch(
          import.meta.env.VITE_DJANGOURL + '/api/v1/personas/' +
            persona_id +
            "/",
          {
            method: "DELETE",
          }
        );
        this.personas = this.personas.filter((u) => u.id !== persona_id);
      } catch (error) {
        console.error(error);
      }
    },
    async actualizarPersona(id, personaActualizada) {
      try {
        const response = await fetch(
          import.meta.env.VITE_DJANGOURL + '/api/v1/personas/' +
            personaActualizada.id +
            "/",
          {
            method: "PUT",
            body: JSON.stringify(personaActualizada),
            headers: { "Content-type": "application/json; charset=UTF-8" },
          }
        );
        const personaActualizadaJS = await response.json();
        this.personas = this.personas.map((u) =>
          u.id === personaActualizada.id ? personaActualizadaJS : u
        );
      } catch (error) {
        console.error(error);
      }
    },
  },
  mounted() {
    this.listadoPersonas();
  },
};
</script>
<style>
button {
  background: #009435;
  border: 1px solid #009435;
}
</style>
