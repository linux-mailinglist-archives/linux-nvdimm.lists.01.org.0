Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA6619DE98
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 21:36:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64822100E3FC3;
	Fri,  3 Apr 2020 12:36:55 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vajain21@vajain21.in.ibm.com.in.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AFB24100E3FC2
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 12:36:52 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033JXXTZ007367
	for <linux-nvdimm@lists.01.org>; Fri, 3 Apr 2020 15:36:02 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 305s83p25p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 03 Apr 2020 15:36:01 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vajain21@vajain21.in.ibm.com.in.ibm.com>;
	Fri, 3 Apr 2020 20:35:39 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 3 Apr 2020 20:35:36 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 033JZtwO3997832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2020 19:35:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 094A042047;
	Fri,  3 Apr 2020 19:35:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C9942045;
	Fri,  3 Apr 2020 19:35:52 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.60.182])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri,  3 Apr 2020 19:35:52 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Sat, 04 Apr 2020 01:05:51 +0530
From: Vaibhav Jain <vajain21@vajain21.in.ibm.com.in.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] libnvdimm: Validate command family indices
In-Reply-To: <158593318491.130477.12103487421973195234.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158593318491.130477.12103487421973195234.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Sat, 04 Apr 2020 01:05:51 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20040319-0020-0000-0000-000003C10EDB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040319-0021-0000-0000-00002219C0F2
Message-Id: <871rp4tl9k.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_15:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1034 priorityscore=1501 mlxscore=0 suspectscore=1 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030154
Message-ID-Hash: EK32FUF43L5F5X5JDBJLDN5AALT4WDV3
X-Message-ID-Hash: EK32FUF43L5F5X5JDBJLDN5AALT4WDV3
X-MailFrom: vajain21@vajain21.in.ibm.com.in.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: vaibhav@linux.ibm.com, aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EK32FUF43L5F5X5JDBJLDN5AALT4WDV3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

This sounds like good idea and would reduce some cmd_pkg checking overhead in
nvdimm and bus modules. However have few concerns regarding the proposed
PAPR_SCM command family below

Dan Williams <dan.j.williams@intel.com> writes:

> The ND_CMD_CALL format allows for a general passthrough of whitelisted
> commands targeting a given command set. However there is no validation
> of the family index relative to what the bus supports.
>
> - Update the NFIT bus implementation (the only one that supports
>   ND_CMD_CALL passthrough) to also whitelist the valid set of command
>   family indices.
PAPR_SCM command family will also use ND_CMD_CALL passthrough and will
need to be whitelist even though it doesnt use NFIT.

>
> - Update the generic __nd_ioctl() path to validate that field on behalf
>   of all implementations.
>
> Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit/core.c   |   11 +++++++++--
>  drivers/acpi/nfit/nfit.h   |    1 -
>  drivers/nvdimm/bus.c       |   16 ++++++++++++++++
>  include/linux/libnvdimm.h  |    2 ++
>  include/uapi/linux/ndctl.h |    4 ++++
>  5 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index d0090f71585c..bcf5af803941 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1823,6 +1823,7 @@ static void populate_shutdown_status(struct nfit_mem *nfit_mem)
>  static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>  		struct nfit_mem *nfit_mem, u32 device_handle)
>  {
> +	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
>  	struct acpi_device *adev, *adev_dimm;
>  	struct device *dev = acpi_desc->dev;
>  	unsigned long dsm_mask, label_mask;
> @@ -1834,6 +1835,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>  	/* nfit test assumes 1:1 relationship between commands and dsms */
>  	nfit_mem->dsm_mask = acpi_desc->dimm_cmd_force_en;
>  	nfit_mem->family = NVDIMM_FAMILY_INTEL;
> +	set_bit(NVDIMM_FAMILY_INTEL, &nd_desc->dimm_family_mask);
>  
>  	if (dcr->valid_fields & ACPI_NFIT_CONTROL_MFG_INFO_VALID)
>  		sprintf(nfit_mem->id, "%04x-%02x-%04x-%08x",
> @@ -1886,10 +1888,13 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>  	 * Note, that checking for function0 (bit0) tells us if any commands
>  	 * are reachable through this GUID.
>  	 */
> +	clear_bit(NVDIMM_FAMILY_INTEL, &nd_desc->dimm_family_mask);
>  	for (i = 0; i <= NVDIMM_FAMILY_MAX; i++)
> -		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1))
> +		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1)) {
> +			set_bit(i, &nd_desc->dimm_family_mask);
>  			if (family < 0 || i == default_dsm_family)
>  				family = i;
> +		}
>  
>  	/* limit the supported commands to those that are publicly documented */
>  	nfit_mem->family = family;
> @@ -2151,6 +2156,9 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
>  
>  	nd_desc->cmd_mask = acpi_desc->bus_cmd_force_en;
>  	nd_desc->bus_dsm_mask = acpi_desc->bus_nfit_cmd_force_en;
> +	set_bit(ND_CMD_CALL, &nd_desc->cmd_mask);
> +	set_bit(NVDIMM_BUS_FAMILY_NFIT, &nd_desc->bus_family_mask);
> +
>  	adev = to_acpi_dev(acpi_desc);
>  	if (!adev)
>  		return;
> @@ -2158,7 +2166,6 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
>  	for (i = ND_CMD_ARS_CAP; i <= ND_CMD_CLEAR_ERROR; i++)
>  		if (acpi_check_dsm(adev->handle, guid, 1, 1ULL << i))
>  			set_bit(i, &nd_desc->cmd_mask);
> -	set_bit(ND_CMD_CALL, &nd_desc->cmd_mask);
>  
>  	dsm_mask =
>  		(1 << ND_CMD_ARS_CAP) |
> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index b317f4043705..5f5f8ce030e7 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -33,7 +33,6 @@
>  		| ACPI_NFIT_MEM_RESTORE_FAILED | ACPI_NFIT_MEM_FLUSH_FAILED \
>  		| ACPI_NFIT_MEM_NOT_ARMED | ACPI_NFIT_MEM_MAP_FAILED)
>  
> -#define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV
>  #define NVDIMM_CMD_MAX 31
>  
>  #define NVDIMM_STANDARD_CMDMASK \
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 09087c38fabd..955265656b96 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -1037,9 +1037,25 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
>  		dimm_name = "bus";
>  	}
>  
> +	/* Validate command family support against bus declared support */
>  	if (cmd == ND_CMD_CALL) {
> +		unsigned long *mask;
> +
>  		if (copy_from_user(&pkg, p, sizeof(pkg)))
>  			return -EFAULT;
> +
> +		if (nvdimm) {
> +			if (pkg.nd_family > NVDIMM_FAMILY_MAX)
> +				return -EINVAL;
> +			mask = &nd_desc->dimm_family_mask;
> +		} else {
> +			if (pkg.nd_family > NVDIMM_BUS_FAMILY_MAX)
> +				return -EINVAL;
> +			mask = &nd_desc->bus_family_mask;
> +		}
> +
> +		if (!test_bit(pkg.nd_family, mask))
> +			return -EINVAL;
>  	}
>  
>  	if (!desc ||
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 9df091bd30ba..b41857f43883 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -76,6 +76,8 @@ struct nvdimm_bus_descriptor {
>  	const struct attribute_group **attr_groups;
>  	unsigned long bus_dsm_mask;
>  	unsigned long cmd_mask;
> +	unsigned long dimm_family_mask;
> +	unsigned long bus_family_mask;
>  	struct module *module;
>  	char *provider_name;
>  	struct device_node *of_node;
> diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
> index de5d90212409..e28763c234e2 100644
> --- a/include/uapi/linux/ndctl.h
> +++ b/include/uapi/linux/ndctl.h
> @@ -244,6 +244,10 @@ struct nd_cmd_pkg {
>  #define NVDIMM_FAMILY_HPE2 2
>  #define NVDIMM_FAMILY_MSFT 3
>  #define NVDIMM_FAMILY_HYPERV 4
> +#define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV

How do you envision support for a new command family that doesnt
support NFIT like PAPR_SCM, be added to this list ?

As I see the value NVDIMM_FAMILY_MAX will be tied to the set of command
families supported by nfit and if PAPR_SCM command family is added at
index 5 then should or should-not the NVDIMM_FAMILY_MAX be updated to
value 5.

If NVDIMM_FAMILY_MAX is not updated then __nd_ioctl() wont let PAPR-SCM
commands pass through. However if NVDIMM_FAMILY_MAX is updated then nfit
module will wrongly advertise support for PAPR-SCM command family.

> +
> +#define NVDIMM_BUS_FAMILY_NFIT 0
> +#define NVDIMM_BUS_FAMILY_MAX NVDIMM_BUS_FAMILY_NFIT
>  
>  #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
>  					struct nd_cmd_pkg)
>
Thanks,
-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
