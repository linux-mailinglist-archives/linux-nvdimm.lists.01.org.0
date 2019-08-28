Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 751E5A090F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 19:56:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E7DB820215F4D;
	Wed, 28 Aug 2019 10:58:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CAA4C2020D336
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 10:58:47 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 942907F75E;
 Wed, 28 Aug 2019 17:56:46 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E344A5C1D6;
 Wed, 28 Aug 2019 17:56:45 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/3] libnvdimm/security: Introduce a 'frozen' attribute
References: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156686729474.184120.5835135644278860826.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 28 Aug 2019 13:56:44 -0400
In-Reply-To: <156686729474.184120.5835135644278860826.stgit@dwillia2-desk3.amr.corp.intel.com>
 (Dan Williams's message of "Mon, 26 Aug 2019 17:54:54 -0700")
Message-ID: <x49blw9897n.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 28 Aug 2019 17:56:46 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Dan Williams <dan.j.williams@intel.com> writes:

> In the process of debugging a system with an NVDIMM that was failing to
> unlock it was found that the kernel is reporting 'locked' while the DIMM
> security interface is 'frozen'. Unfortunately the security state is
> tracked internally as an enum which prevents it from communicating the
> difference between 'locked' and 'locked + frozen'. It follows that the
> enum also prevents the kernel from communicating 'unlocked + frozen'
> which would be useful for debugging why security operations like 'change
> passphrase' are disabled.
>
> Ditch the security state enum for a set of flags and introduce a new
> sysfs attribute explicitly for the 'frozen' state. The regression risk
> is low because the 'frozen' state was already blocked behind the
> 'locked' state, but will need to revisit if there were cases where
> applications need 'frozen' to show up in the primary 'security'
> attribute. The expectation is that communicating 'frozen' is mostly a
> helper for debug and status monitoring.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

> ---
>  drivers/acpi/nfit/intel.c        |   59 ++++++++++++-----------
>  drivers/nvdimm/bus.c             |    2 -
>  drivers/nvdimm/dimm_devs.c       |   59 +++++++++++++----------
>  drivers/nvdimm/nd-core.h         |   21 ++++++--
>  drivers/nvdimm/security.c        |   99 ++++++++++++++++++--------------------
>  include/linux/libnvdimm.h        |    9 ++-
>  tools/testing/nvdimm/dimm_devs.c |   19 ++-----
>  7 files changed, 141 insertions(+), 127 deletions(-)
>
> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> index cddd0fcf622c..1113b679cd7b 100644
> --- a/drivers/acpi/nfit/intel.c
> +++ b/drivers/acpi/nfit/intel.c
> @@ -7,10 +7,11 @@
>  #include "intel.h"
>  #include "nfit.h"
>  
> -static enum nvdimm_security_state intel_security_state(struct nvdimm *nvdimm,
> +static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>  		enum nvdimm_passphrase_type ptype)
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	unsigned long security_flags = 0;
>  	struct {
>  		struct nd_cmd_pkg pkg;
>  		struct nd_intel_get_security_state cmd;
> @@ -27,7 +28,7 @@ static enum nvdimm_security_state intel_security_state(struct nvdimm *nvdimm,
>  	int rc;
>  
>  	if (!test_bit(NVDIMM_INTEL_GET_SECURITY_STATE, &nfit_mem->dsm_mask))
> -		return -ENXIO;
> +		return 0;
>  
>  	/*
>  	 * Short circuit the state retrieval while we are doing overwrite.
> @@ -35,38 +36,42 @@ static enum nvdimm_security_state intel_security_state(struct nvdimm *nvdimm,
>  	 * until the overwrite DSM completes.
>  	 */
>  	if (nvdimm_in_overwrite(nvdimm) && ptype == NVDIMM_USER)
> -		return NVDIMM_SECURITY_OVERWRITE;
> +		return BIT(NVDIMM_SECURITY_OVERWRITE);
>  
>  	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
> -	if (rc < 0)
> -		return rc;
> -	if (nd_cmd.cmd.status)
> -		return -EIO;
> +	if (rc < 0 || nd_cmd.cmd.status) {
> +		pr_err("%s: security state retrieval failed (%d:%#x)\n",
> +				nvdimm_name(nvdimm), rc, nd_cmd.cmd.status);
> +		return 0;
> +	}
>  
>  	/* check and see if security is enabled and locked */
>  	if (ptype == NVDIMM_MASTER) {
>  		if (nd_cmd.cmd.extended_state & ND_INTEL_SEC_ESTATE_ENABLED)
> -			return NVDIMM_SECURITY_UNLOCKED;
> -		else if (nd_cmd.cmd.extended_state &
> -				ND_INTEL_SEC_ESTATE_PLIMIT)
> -			return NVDIMM_SECURITY_FROZEN;
> -	} else {
> -		if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_UNSUPPORTED)
> -			return -ENXIO;
> -		else if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_ENABLED) {
> -			if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_LOCKED)
> -				return NVDIMM_SECURITY_LOCKED;
> -			else if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_FROZEN
> -					|| nd_cmd.cmd.state &
> -					ND_INTEL_SEC_STATE_PLIMIT)
> -				return NVDIMM_SECURITY_FROZEN;
> -			else
> -				return NVDIMM_SECURITY_UNLOCKED;
> -		}
> +			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
> +		else
> +			set_bit(NVDIMM_SECURITY_DISABLED, &security_flags);
> +		if (nd_cmd.cmd.extended_state & ND_INTEL_SEC_ESTATE_PLIMIT)
> +			set_bit(NVDIMM_SECURITY_FROZEN, &security_flags);
> +		return security_flags;
>  	}
>  
> -	/* this should cover master security disabled as well */
> -	return NVDIMM_SECURITY_DISABLED;
> +	if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_UNSUPPORTED)
> +		return 0;
> +
> +	if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_ENABLED) {
> +		if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_FROZEN ||
> +		    nd_cmd.cmd.state & ND_INTEL_SEC_STATE_PLIMIT)
> +			set_bit(NVDIMM_SECURITY_FROZEN, &security_flags);
> +
> +		if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_LOCKED)
> +			set_bit(NVDIMM_SECURITY_LOCKED, &security_flags);
> +		else
> +			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
> +	} else
> +		set_bit(NVDIMM_SECURITY_DISABLED, &security_flags);
> +
> +	return security_flags;
>  }
>  
>  static int intel_security_freeze(struct nvdimm *nvdimm)
> @@ -371,7 +376,7 @@ static void nvdimm_invalidate_cache(void)
>  #endif
>  
>  static const struct nvdimm_security_ops __intel_security_ops = {
> -	.state = intel_security_state,
> +	.get_flags = intel_security_flags,
>  	.freeze = intel_security_freeze,
>  	.change_key = intel_security_change_key,
>  	.disable = intel_security_disable,
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 798c5c4aea9c..29479d3b01b0 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -400,7 +400,7 @@ static int child_unregister(struct device *dev, void *data)
>  
>  		/* We are shutting down. Make state frozen artificially. */
>  		nvdimm_bus_lock(dev);
> -		nvdimm->sec.state = NVDIMM_SECURITY_FROZEN;
> +		set_bit(NVDIMM_SECURITY_FROZEN, &nvdimm->sec.flags);
>  		if (test_and_clear_bit(NDD_WORK_PENDING, &nvdimm->flags))
>  			dev_put = true;
>  		nvdimm_bus_unlock(dev);
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 29a065e769ea..53330625fe07 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -372,24 +372,27 @@ __weak ssize_t security_show(struct device *dev,
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> -	switch (nvdimm->sec.state) {
> -	case NVDIMM_SECURITY_DISABLED:
> +	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
>  		return sprintf(buf, "disabled\n");
> -	case NVDIMM_SECURITY_UNLOCKED:
> +	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
>  		return sprintf(buf, "unlocked\n");
> -	case NVDIMM_SECURITY_LOCKED:
> +	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
>  		return sprintf(buf, "locked\n");
> -	case NVDIMM_SECURITY_FROZEN:
> -		return sprintf(buf, "frozen\n");
> -	case NVDIMM_SECURITY_OVERWRITE:
> +	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
>  		return sprintf(buf, "overwrite\n");
> -	default:
> -		return -ENOTTY;
> -	}
> -
>  	return -ENOTTY;
>  }
>  
> +static ssize_t frozen_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +
> +	return sprintf(buf, "%d\n", test_bit(NVDIMM_SECURITY_FROZEN,
> +				&nvdimm->sec.flags));
> +}
> +static DEVICE_ATTR_RO(frozen);
> +
>  #define OPS							\
>  	C( OP_FREEZE,		"freeze",		1),	\
>  	C( OP_DISABLE,		"disable",		2),	\
> @@ -501,6 +504,7 @@ static struct attribute *nvdimm_attributes[] = {
>  	&dev_attr_commands.attr,
>  	&dev_attr_available_slots.attr,
>  	&dev_attr_security.attr,
> +	&dev_attr_frozen.attr,
>  	NULL,
>  };
>  
> @@ -509,17 +513,24 @@ static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct device *dev = container_of(kobj, typeof(*dev), kobj);
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> -	if (a != &dev_attr_security.attr)
> +	if (a != &dev_attr_security.attr && a != &dev_attr_frozen.attr)
>  		return a->mode;
> -	if (nvdimm->sec.state < 0)
> +	if (!nvdimm->sec.flags)
>  		return 0;
> -	/* Are there any state mutation ops? */
> -	if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
> -			|| nvdimm->sec.ops->change_key
> -			|| nvdimm->sec.ops->erase
> -			|| nvdimm->sec.ops->overwrite)
> +
> +	if (a == &dev_attr_security.attr) {
> +		/* Are there any state mutation ops (make writable)? */
> +		if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
> +				|| nvdimm->sec.ops->change_key
> +				|| nvdimm->sec.ops->erase
> +				|| nvdimm->sec.ops->overwrite)
> +			return a->mode;
> +		return 0444;
> +	}
> +
> +	if (nvdimm->sec.ops->freeze)
>  		return a->mode;
> -	return 0444;
> +	return 0;
>  }
>  
>  struct attribute_group nvdimm_attribute_group = {
> @@ -569,8 +580,8 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
>  	 * attribute visibility.
>  	 */
>  	/* get security state and extended (master) state */
> -	nvdimm->sec.state = nvdimm_security_state(nvdimm, NVDIMM_USER);
> -	nvdimm->sec.ext_state = nvdimm_security_state(nvdimm, NVDIMM_MASTER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
> +	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
>  	nd_device_register(dev);
>  
>  	return nvdimm;
> @@ -588,7 +599,7 @@ int nvdimm_security_setup_events(struct device *dev)
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> -	if (nvdimm->sec.state < 0 || !nvdimm->sec.ops
> +	if (!nvdimm->sec.flags || !nvdimm->sec.ops
>  			|| !nvdimm->sec.ops->overwrite)
>  		return 0;
>  	nvdimm->sec.overwrite_state = sysfs_get_dirent(dev->kobj.sd, "security");
> @@ -614,7 +625,7 @@ int nvdimm_security_freeze(struct nvdimm *nvdimm)
>  	if (!nvdimm->sec.ops || !nvdimm->sec.ops->freeze)
>  		return -EOPNOTSUPP;
>  
> -	if (nvdimm->sec.state < 0)
> +	if (!nvdimm->sec.flags)
>  		return -EIO;
>  
>  	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
> @@ -623,7 +634,7 @@ int nvdimm_security_freeze(struct nvdimm *nvdimm)
>  	}
>  
>  	rc = nvdimm->sec.ops->freeze(nvdimm);
> -	nvdimm->sec.state = nvdimm_security_state(nvdimm, NVDIMM_USER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>  
>  	return rc;
>  }
> diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
> index 0ac52b6eb00e..da2bbfd56d9f 100644
> --- a/drivers/nvdimm/nd-core.h
> +++ b/drivers/nvdimm/nd-core.h
> @@ -39,21 +39,32 @@ struct nvdimm {
>  	const char *dimm_id;
>  	struct {
>  		const struct nvdimm_security_ops *ops;
> -		enum nvdimm_security_state state;
> -		enum nvdimm_security_state ext_state;
> +		unsigned long flags;
> +		unsigned long ext_flags;
>  		unsigned int overwrite_tmo;
>  		struct kernfs_node *overwrite_state;
>  	} sec;
>  	struct delayed_work dwork;
>  };
>  
> -static inline enum nvdimm_security_state nvdimm_security_state(
> +static inline unsigned long nvdimm_security_flags(
>  		struct nvdimm *nvdimm, enum nvdimm_passphrase_type ptype)
>  {
> +	u64 flags;
> +	const u64 state_flags = 1UL << NVDIMM_SECURITY_DISABLED
> +		| 1UL << NVDIMM_SECURITY_LOCKED
> +		| 1UL << NVDIMM_SECURITY_UNLOCKED
> +		| 1UL << NVDIMM_SECURITY_OVERWRITE;
> +
>  	if (!nvdimm->sec.ops)
> -		return -ENXIO;
> +		return 0;
>  
> -	return nvdimm->sec.ops->state(nvdimm, ptype);
> +	flags = nvdimm->sec.ops->get_flags(nvdimm, ptype);
> +	/* disabled, locked, unlocked, and overwrite are mutually exclusive */
> +	dev_WARN_ONCE(&nvdimm->dev, hweight64(flags & state_flags) > 1,
> +			"reported invalid security state: %#llx\n",
> +			(unsigned long long) flags);
> +	return flags;
>  }
>  int nvdimm_security_freeze(struct nvdimm *nvdimm);
>  #if IS_ENABLED(CONFIG_NVDIMM_KEYS)
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index a570f2263a42..5862d0eee9db 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -158,7 +158,7 @@ static int nvdimm_key_revalidate(struct nvdimm *nvdimm)
>  	}
>  
>  	nvdimm_put_key(key);
> -	nvdimm->sec.state = nvdimm_security_state(nvdimm, NVDIMM_USER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>  	return 0;
>  }
>  
> @@ -174,7 +174,7 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
>  	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
>  
>  	if (!nvdimm->sec.ops || !nvdimm->sec.ops->unlock
> -			|| nvdimm->sec.state < 0)
> +			|| !nvdimm->sec.flags)
>  		return -EIO;
>  
>  	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
> @@ -189,7 +189,7 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
>  	 * freeze of the security configuration. I.e. if the OS does not
>  	 * have the key, security is being managed pre-OS.
>  	 */
> -	if (nvdimm->sec.state == NVDIMM_SECURITY_UNLOCKED) {
> +	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags)) {
>  		if (!key_revalidate)
>  			return 0;
>  
> @@ -202,7 +202,7 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
>  			rc == 0 ? "success" : "fail");
>  
>  	nvdimm_put_key(key);
> -	nvdimm->sec.state = nvdimm_security_state(nvdimm, NVDIMM_USER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>  	return rc;
>  }
>  
> @@ -217,6 +217,24 @@ int nvdimm_security_unlock(struct device *dev)
>  	return rc;
>  }
>  
> +static int check_security_state(struct nvdimm *nvdimm)
> +{
> +	struct device *dev = &nvdimm->dev;
> +
> +	if (test_bit(NVDIMM_SECURITY_FROZEN, &nvdimm->sec.flags)) {
> +		dev_dbg(dev, "Incorrect security state: %#lx\n",
> +				nvdimm->sec.flags);
> +		return -EIO;
> +	}
> +
> +	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
> +		dev_dbg(dev, "Security operation in progress.\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  int nvdimm_security_disable(struct nvdimm *nvdimm, unsigned int keyid)
>  {
>  	struct device *dev = &nvdimm->dev;
> @@ -229,19 +247,12 @@ int nvdimm_security_disable(struct nvdimm *nvdimm, unsigned int keyid)
>  	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
>  
>  	if (!nvdimm->sec.ops || !nvdimm->sec.ops->disable
> -			|| nvdimm->sec.state < 0)
> +			|| !nvdimm->sec.flags)
>  		return -EOPNOTSUPP;
>  
> -	if (nvdimm->sec.state >= NVDIMM_SECURITY_FROZEN) {
> -		dev_dbg(dev, "Incorrect security state: %d\n",
> -				nvdimm->sec.state);
> -		return -EIO;
> -	}
> -
> -	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
> -		dev_dbg(dev, "Security operation in progress.\n");
> -		return -EBUSY;
> -	}
> +	rc = check_security_state(nvdimm);
> +	if (rc)
> +		return rc;
>  
>  	data = nvdimm_get_user_key_payload(nvdimm, keyid,
>  			NVDIMM_BASE_KEY, &key);
> @@ -253,7 +264,7 @@ int nvdimm_security_disable(struct nvdimm *nvdimm, unsigned int keyid)
>  			rc == 0 ? "success" : "fail");
>  
>  	nvdimm_put_key(key);
> -	nvdimm->sec.state = nvdimm_security_state(nvdimm, NVDIMM_USER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>  	return rc;
>  }
>  
> @@ -271,14 +282,12 @@ int nvdimm_security_update(struct nvdimm *nvdimm, unsigned int keyid,
>  	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
>  
>  	if (!nvdimm->sec.ops || !nvdimm->sec.ops->change_key
> -			|| nvdimm->sec.state < 0)
> +			|| !nvdimm->sec.flags)
>  		return -EOPNOTSUPP;
>  
> -	if (nvdimm->sec.state >= NVDIMM_SECURITY_FROZEN) {
> -		dev_dbg(dev, "Incorrect security state: %d\n",
> -				nvdimm->sec.state);
> -		return -EIO;
> -	}
> +	rc = check_security_state(nvdimm);
> +	if (rc)
> +		return rc;
>  
>  	data = nvdimm_get_user_key_payload(nvdimm, keyid,
>  			NVDIMM_BASE_KEY, &key);
> @@ -301,10 +310,10 @@ int nvdimm_security_update(struct nvdimm *nvdimm, unsigned int keyid,
>  	nvdimm_put_key(newkey);
>  	nvdimm_put_key(key);
>  	if (pass_type == NVDIMM_MASTER)
> -		nvdimm->sec.ext_state = nvdimm_security_state(nvdimm,
> +		nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm,
>  				NVDIMM_MASTER);
>  	else
> -		nvdimm->sec.state = nvdimm_security_state(nvdimm,
> +		nvdimm->sec.flags = nvdimm_security_flags(nvdimm,
>  				NVDIMM_USER);
>  	return rc;
>  }
> @@ -322,7 +331,7 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
>  	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
>  
>  	if (!nvdimm->sec.ops || !nvdimm->sec.ops->erase
> -			|| nvdimm->sec.state < 0)
> +			|| !nvdimm->sec.flags)
>  		return -EOPNOTSUPP;
>  
>  	if (atomic_read(&nvdimm->busy)) {
> @@ -330,18 +339,11 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
>  		return -EBUSY;
>  	}
>  
> -	if (nvdimm->sec.state >= NVDIMM_SECURITY_FROZEN) {
> -		dev_dbg(dev, "Incorrect security state: %d\n",
> -				nvdimm->sec.state);
> -		return -EIO;
> -	}
> -
> -	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
> -		dev_dbg(dev, "Security operation in progress.\n");
> -		return -EBUSY;
> -	}
> +	rc = check_security_state(nvdimm);
> +	if (rc)
> +		return rc;
>  
> -	if (nvdimm->sec.ext_state != NVDIMM_SECURITY_UNLOCKED
> +	if (!test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.ext_flags)
>  			&& pass_type == NVDIMM_MASTER) {
>  		dev_dbg(dev,
>  			"Attempt to secure erase in wrong master state.\n");
> @@ -359,7 +361,7 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
>  			rc == 0 ? "success" : "fail");
>  
>  	nvdimm_put_key(key);
> -	nvdimm->sec.state = nvdimm_security_state(nvdimm, NVDIMM_USER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>  	return rc;
>  }
>  
> @@ -375,7 +377,7 @@ int nvdimm_security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
>  	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
>  
>  	if (!nvdimm->sec.ops || !nvdimm->sec.ops->overwrite
> -			|| nvdimm->sec.state < 0)
> +			|| !nvdimm->sec.flags)
>  		return -EOPNOTSUPP;
>  
>  	if (atomic_read(&nvdimm->busy)) {
> @@ -388,16 +390,9 @@ int nvdimm_security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
>  		return -EINVAL;
>  	}
>  
> -	if (nvdimm->sec.state >= NVDIMM_SECURITY_FROZEN) {
> -		dev_dbg(dev, "Incorrect security state: %d\n",
> -				nvdimm->sec.state);
> -		return -EIO;
> -	}
> -
> -	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
> -		dev_dbg(dev, "Security operation in progress.\n");
> -		return -EBUSY;
> -	}
> +	rc = check_security_state(nvdimm);
> +	if (rc)
> +		return rc;
>  
>  	data = nvdimm_get_user_key_payload(nvdimm, keyid,
>  			NVDIMM_BASE_KEY, &key);
> @@ -412,7 +407,7 @@ int nvdimm_security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
>  	if (rc == 0) {
>  		set_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
>  		set_bit(NDD_WORK_PENDING, &nvdimm->flags);
> -		nvdimm->sec.state = NVDIMM_SECURITY_OVERWRITE;
> +		set_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags);
>  		/*
>  		 * Make sure we don't lose device while doing overwrite
>  		 * query.
> @@ -443,7 +438,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  	tmo = nvdimm->sec.overwrite_tmo;
>  
>  	if (!nvdimm->sec.ops || !nvdimm->sec.ops->query_overwrite
> -			|| nvdimm->sec.state < 0)
> +			|| !nvdimm->sec.flags)
>  		return;
>  
>  	rc = nvdimm->sec.ops->query_overwrite(nvdimm);
> @@ -467,8 +462,8 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  	clear_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
>  	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
>  	put_device(&nvdimm->dev);
> -	nvdimm->sec.state = nvdimm_security_state(nvdimm, NVDIMM_USER);
> -	nvdimm->sec.ext_state = nvdimm_security_state(nvdimm, NVDIMM_MASTER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
>  }
>  
>  void nvdimm_security_overwrite_query(struct work_struct *work)
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 7a64b3ddb408..b6eddf912568 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -160,8 +160,11 @@ static inline struct nd_blk_region_desc *to_blk_region_desc(
>  
>  }
>  
> -enum nvdimm_security_state {
> -	NVDIMM_SECURITY_ERROR = -1,
> +/*
> + * Note that separate bits for locked + unlocked are defined so that
> + * 'flags == 0' corresponds to an error / not-supported state.
> + */
> +enum nvdimm_security_bits {
>  	NVDIMM_SECURITY_DISABLED,
>  	NVDIMM_SECURITY_UNLOCKED,
>  	NVDIMM_SECURITY_LOCKED,
> @@ -182,7 +185,7 @@ enum nvdimm_passphrase_type {
>  };
>  
>  struct nvdimm_security_ops {
> -	enum nvdimm_security_state (*state)(struct nvdimm *nvdimm,
> +	unsigned long (*get_flags)(struct nvdimm *nvdimm,
>  			enum nvdimm_passphrase_type pass_type);
>  	int (*freeze)(struct nvdimm *nvdimm);
>  	int (*change_key)(struct nvdimm *nvdimm,
> diff --git a/tools/testing/nvdimm/dimm_devs.c b/tools/testing/nvdimm/dimm_devs.c
> index 2d4baf57822f..57bd27dedf1f 100644
> --- a/tools/testing/nvdimm/dimm_devs.c
> +++ b/tools/testing/nvdimm/dimm_devs.c
> @@ -18,24 +18,13 @@ ssize_t security_show(struct device *dev,
>  	 * For the test version we need to poll the "hardware" in order
>  	 * to get the updated status for unlock testing.
>  	 */
> -	nvdimm->sec.state = nvdimm_security_state(nvdimm, NVDIMM_USER);
> -	nvdimm->sec.ext_state = nvdimm_security_state(nvdimm, NVDIMM_MASTER);
> +	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>  
> -	switch (nvdimm->sec.state) {
> -	case NVDIMM_SECURITY_DISABLED:
> +	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
>  		return sprintf(buf, "disabled\n");
> -	case NVDIMM_SECURITY_UNLOCKED:
> +	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
>  		return sprintf(buf, "unlocked\n");
> -	case NVDIMM_SECURITY_LOCKED:
> +	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
>  		return sprintf(buf, "locked\n");
> -	case NVDIMM_SECURITY_FROZEN:
> -		return sprintf(buf, "frozen\n");
> -	case NVDIMM_SECURITY_OVERWRITE:
> -		return sprintf(buf, "overwrite\n");
> -	default:
> -		return -ENOTTY;
> -	}
> -
>  	return -ENOTTY;
>  }
> -
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
