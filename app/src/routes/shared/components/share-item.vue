<template>
	<v-form
		v-model="edits"
		:collection="collection"
		:initial-values="item"
		:primary-key="primaryKey"
		disabled
		:loading="loading"
	/>
	<template v-if="updateAllowed">
		<v-notice type="normal">{{ t('shared_login_to_update') }}</v-notice>
		<div class="buttons">
			<v-button @click="redirectToLogin">{{ t('login') }}</v-button>
		</div>
	</template>
</template>

<script lang="ts">
import { useI18n } from 'vue-i18n';
import { defineComponent, toRefs, ref } from 'vue';
import { useItem } from '@/composables/use-item';
import { usePermissions } from '@/composables/use-permissions';
import { logout } from '@/auth';

export default defineComponent({
	id: 'ShareItem',
	props: {
		collection: {
			type: String,
			required: true,
		},
		primaryKey: {
			type: String,
			required: true,
		},
	},
	setup(props) {
		const { t } = useI18n();
		const { collection, primaryKey } = toRefs(props);
		const { edits, item, loading } = useItem(collection, primaryKey);
		const { updateAllowed } = usePermissions(collection, item, ref(false));

		async function redirectToLogin() {
			await logout({ navigate: true });
		}

		return { edits, item, loading, updateAllowed, redirectToLogin, t };
	},
});
</script>

<style lang="scss" scoped>
.v-notice {
	margin-top: 1em;
}
.buttons {
	margin-top: 1em;
	display: flex;
	align-items: center;
	justify-content: space-between;
}
</style>
