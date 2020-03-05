Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62306179E23
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Mar 2020 04:11:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07C6D10FC36F6;
	Wed,  4 Mar 2020 19:12:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B083510FC36DC
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 19:12:32 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 025398UX057424
	for <linux-nvdimm@lists.01.org>; Wed, 4 Mar 2020 22:11:40 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yhs0uvya9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 04 Mar 2020 22:11:40 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Thu, 5 Mar 2020 03:11:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 5 Mar 2020 03:11:29 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0253BSml56099026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2020 03:11:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C792BA4054;
	Thu,  5 Mar 2020 03:11:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CD0BA4060;
	Thu,  5 Mar 2020 03:11:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  5 Mar 2020 03:11:28 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2C378A0264;
	Thu,  5 Mar 2020 14:11:23 +1100 (AEDT)
Subject: Re: [PATCH v3 23/27] powerpc/powernv/pmem: Add debug IOCTLs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-24-alastair@au1.ibm.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Thu, 5 Mar 2020 14:11:26 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-24-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030503-0028-0000-0000-000003E0FEB2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030503-0029-0000-0000-000024A631F9
Message-Id: <5e2be4dd-bc8b-ff2c-d057-acd5f3728f4a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_10:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050015
Message-ID-Hash: UMZYQLHEMI23IRKOXM4JECHSOWEK3NGP
X-Message-ID-Hash: UMZYQLHEMI23IRKOXM4JECHSOWEK3NGP
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc
 -dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UMZYQLHEMI23IRKOXM4JECHSOWEK3NGP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> These IOCTLs provide low level access to the card to aid in debugging
> controller/FPGA firmware.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/platforms/powernv/pmem/Kconfig |   6 +
>   arch/powerpc/platforms/powernv/pmem/ocxl.c  | 249 ++++++++++++++++++++
>   include/uapi/nvdimm/ocxl-pmem.h             |  32 +++
>   3 files changed, 287 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pmem/Kconfig b/arch/powerpc/platforms/powernv/pmem/Kconfig
> index c5d927520920..3f44429d70c9 100644
> --- a/arch/powerpc/platforms/powernv/pmem/Kconfig
> +++ b/arch/powerpc/platforms/powernv/pmem/Kconfig
> @@ -12,4 +12,10 @@ config OCXL_PMEM
>   
>   	  Select N if unsure.
>   
> +config OCXL_PMEM_DEBUG
> +	bool "OpenCAPI Persistent Memory debugging"
> +	depends on OCXL_PMEM
> +	help
> +	  Enables low level IOCTLs for OpenCAPI Persistent Memory firmware development
> +

How dangerous are these ioctls and does that need to be pointed out in 
this description?

>   endif
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> index e01f6f9fc180..d4ce5e9e0521 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> @@ -1050,6 +1050,235 @@ int req_controller_health_perf(struct ocxlpmem *ocxlpmem)
>   				      GLOBAL_MMIO_HCI_REQ_HEALTH_PERF);
>   }
>   
> +#ifdef CONFIG_OCXL_PMEM_DEBUG
> +/**
> + * enable_fwdebug() - Enable FW debug on the controller
> + * @ocxlpmem: the device metadata
> + * Return: 0 on success, negative on failure
> + */
> +static int enable_fwdebug(const struct ocxlpmem *ocxlpmem)
> +{
> +	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCI,
> +				      OCXL_LITTLE_ENDIAN,
> +				      GLOBAL_MMIO_HCI_FW_DEBUG);
> +}
> +
> +/**
> + * disable_fwdebug() - Disable FW debug on the controller
> + * @ocxlpmem: the device metadata
> + * Return: 0 on success, negative on failure
> + */
> +static int disable_fwdebug(const struct ocxlpmem *ocxlpmem)
> +{
> +	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCIC,
> +				      OCXL_LITTLE_ENDIAN,
> +				      GLOBAL_MMIO_HCI_FW_DEBUG);
> +}
> +
> +static int ioctl_fwdebug(struct ocxlpmem *ocxlpmem,
> +			     struct ioctl_ocxl_pmem_fwdebug __user *uarg)
> +{
> +	struct ioctl_ocxl_pmem_fwdebug args;
> +	u64 val;
> +	int i;
> +	int rc;
> +
> +	if (copy_from_user(&args, uarg, sizeof(args)))
> +		return -EFAULT;
> +
> +	// Buffer size must be a multiple of 8
> +	if ((args.buf_size & 0x07))
> +		return -EINVAL;
> +
> +	if (args.buf_size > ocxlpmem->admin_command.data_size)
> +		return -EINVAL;
> +
> +	mutex_lock(&ocxlpmem->admin_command.lock);
> +
> +	rc = enable_fwdebug(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_FW_DEBUG);
> +	if (rc)
> +		goto out;
> +
> +	// Write DebugAction & FunctionCode
> +	val = ((u64)args.debug_action << 56) | ((u64)args.function_code << 40);
> +
> +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> +				      ocxlpmem->admin_command.request_offset + 0x08,
> +				      OCXL_LITTLE_ENDIAN, val);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> +				      ocxlpmem->admin_command.request_offset + 0x10,
> +				      OCXL_LITTLE_ENDIAN, args.debug_parameter_1);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> +				      ocxlpmem->admin_command.request_offset + 0x18,
> +				      OCXL_LITTLE_ENDIAN, args.debug_parameter_2);
> +	if (rc)
> +		goto out;
> +
> +	for (i = 0x20; i < 0x38; i += 0x08)

Comparison should be <=, the request block ends at 0x40.

But in any case, scm_command_request() should I think already handle the 
clearing of the request block?

> +		rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> +					      ocxlpmem->admin_command.request_offset + i,
> +					      OCXL_LITTLE_ENDIAN, 0);
> +	if (rc)
> +		goto out;
> +
> +
> +	// Populate admin command buffer
> +	if (args.buf_size) {
> +		for (i = 0; i < args.buf_size; i += sizeof(u64)) {
> +			u64 val;
> +
> +			if (copy_from_user(&val, &args.buf[i], sizeof(u64)))
> +				return -EFAULT;
> +
> +			rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> +						      ocxlpmem->admin_command.data_offset + i,
> +						      OCXL_HOST_ENDIAN, val);
> +			if (rc)
> +				goto out;
> +		}
> +	}
> +
> +	rc = admin_command_execute(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +	rc = admin_command_complete_timeout(ocxlpmem,
> +					    ocxlpmem->timeouts[ADMIN_COMMAND_FW_DEBUG]);
> +	if (rc < 0)
> +		goto out;
> +
> +	rc = admin_response(ocxlpmem);
> +	if (rc < 0)
> +		goto out;
> +	if (rc != STATUS_SUCCESS) {
> +		warn_status(ocxlpmem, "Unexpected status from FW Debug", rc);
> +		goto out;
> +	}
> +
> +	if (args.buf_size) {
> +		for (i = 0; i < args.buf_size; i += sizeof(u64)) {
> +			u64 val;
> +
> +			rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +						     ocxlpmem->admin_command.data_offset + i,
> +						     OCXL_HOST_ENDIAN, &val);

No check of the data identifier?

It seems to me that there's no definition in the spec whatsoever for the 
format of the data, so just copying as much as fits in the buffer seems 
correct.

> +			if (rc)
> +				goto out;
> +
> +			if (copy_to_user(&args.buf[i], &val, sizeof(u64))) {
> +				rc = -EFAULT;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	rc = admin_response_handled(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +	rc = disable_fwdebug(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +out:
> +	mutex_unlock(&ocxlpmem->admin_command.lock);
> +	return rc;
> +}
> +
> +static int ioctl_shutdown(struct ocxlpmem *ocxlpmem)
> +{
> +	int rc;
> +
> +	mutex_lock(&ocxlpmem->admin_command.lock);
> +
> +	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_SHUTDOWN);
> +	if (rc)
> +		goto out;
> +
> +	rc = admin_command_execute(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +	rc = admin_command_complete_timeout(ocxlpmem, ADMIN_COMMAND_SHUTDOWN);
> +	if (rc < 0) {
> +		dev_warn(&ocxlpmem->dev, "Shutdown timed out\n");
> +		goto out;
> +	}
> +
> +	rc = 0;
> +	goto out;
> +
> +out:
> +	mutex_unlock(&ocxlpmem->admin_command.lock);
> +	return rc;
> +}
> +
> +static int ioctl_mmio_write(struct ocxlpmem *ocxlpmem,
> +				struct ioctl_ocxl_pmem_mmio __user *uarg)
> +{
> +	struct scm_ioctl_mmio args;
> +
> +	if (copy_from_user(&args, uarg, sizeof(args)))
> +		return -EFAULT;
> +
> +	return ocxl_global_mmio_write64(ocxlpmem->ocxl_afu, args.address,
> +					OCXL_LITTLE_ENDIAN, args.val);
> +}
> +
> +static int ioctl_mmio_read(struct ocxlpmem *ocxlpmem,
> +				     struct ioctl_ocxl_pmem_mmio __user *uarg)
> +{
> +	struct ioctl_ocxl_pmem_mmio args;
> +	int rc;
> +
> +	if (copy_from_user(&args, uarg, sizeof(args)))
> +		return -EFAULT;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, args.address,
> +				     OCXL_LITTLE_ENDIAN, &args.val);
> +	if (rc)
> +		return rc;
> +
> +	if (copy_to_user(uarg, &args, sizeof(args)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +#else /* CONFIG_OCXL_PMEM_DEBUG */
> +static int ioctl_fwdebug(struct ocxlpmem *ocxlpmem,
> +			     struct ioctl_ocxl_pmem_fwdebug __user *uarg)
> +{
> +	return -EPERM;
> +}
> +
> +static int ioctl_shutdown(struct ocxlpmem *ocxlpmem)
> +{
> +	return -EPERM;
> +}
> +
> +static int ioctl_mmio_write(struct ocxlpmem *ocxlpmem,
> +				struct ioctl_ocxl_pmem_mmio __user *uarg)
> +{
> +	return -EPERM;
> +}
> +
> +static int ioctl_mmio_read(struct ocxlpmem *ocxlpmem,
> +			       struct ioctl_ocxl_pmem_mmio __user *uarg)
> +{
> +	return -EPERM;
> +}
> +#endif /* CONFIG_OCXL_PMEM_DEBUG */
> +
>   static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
>   {
>   	struct ocxlpmem *ocxlpmem = file->private_data;
> @@ -1091,6 +1320,26 @@ static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
>   	case IOCTL_OCXL_PMEM_REQUEST_HEALTH:
>   		rc = req_controller_health_perf(ocxlpmem);
>   		break;
> +
> +	case IOCTL_OCXL_PMEM_FWDEBUG:
> +		rc = ioctl_fwdebug(ocxlpmem,
> +				   (struct ioctl_ocxl_pmem_fwdebug __user *)args);
> +		break;
> +
> +	case IOCTL_OCXL_PMEM_SHUTDOWN:
> +		rc = ioctl_shutdown(ocxlpmem);
> +		break;
> +
> +	case IOCTL_OCXL_PMEM_MMIO_WRITE:
> +		rc = ioctl_mmio_write(ocxlpmem,
> +				      (struct ioctl_ocxl_pmem_mmio __user *)args);
> +		break;
> +
> +	case IOCTL_OCXL_PMEM_MMIO_READ:
> +		rc = ioctl_mmio_read(ocxlpmem,
> +				     (struct ioctl_ocxl_pmem_mmio __user *)args);
> +		break;
> +
>   	}
>   
>   	return rc;
> diff --git a/include/uapi/nvdimm/ocxl-pmem.h b/include/uapi/nvdimm/ocxl-pmem.h
> index 0d03abb44001..e20a4f8be82a 100644
> --- a/include/uapi/nvdimm/ocxl-pmem.h
> +++ b/include/uapi/nvdimm/ocxl-pmem.h
> @@ -6,6 +6,28 @@
>   #include <linux/types.h>
>   #include <linux/ioctl.h>
>   
> +enum ocxlpmem_fwdebug_action {
> +	OCXL_PMEM_FWDEBUG_READ_CONTROLLER_MEMORY = 0x01,
> +	OCXL_PMEM_FWDEBUG_WRITE_CONTROLLER_MEMORY = 0x02,
> +	OCXL_PMEM_FWDEBUG_ENABLE_FUNCTION = 0x03,
> +	OCXL_PMEM_FWDEBUG_DISABLE_FUNCTION = 0x04,
> +	OCXL_PMEM_FWDEBUG_GET_PEL = 0x05, // Retrieve Persistent Error Log
> +};
> +
> +struct ioctl_ocxl_pmem_buffer_info {
> +	__u32	admin_command_buffer_size; // out
> +	__u32	near_storage_buffer_size; // out
> +};

This struct seems unused.

> +
> +struct ioctl_ocxl_pmem_fwdebug { // All args are inputs
> +	enum ocxlpmem_fwdebug_action debug_action;
> +	__u16 function_code;
> +	__u16 buf_size; // Size of optional data buffer
> +	__u64 debug_parameter_1;
> +	__u64 debug_parameter_2;
> +	__u8 *buf; // Pointer to optional in/out data buffer
> +};
> +
>   #define OCXL_PMEM_ERROR_LOG_ACTION_RESET	(1 << (32-32))
>   #define OCXL_PMEM_ERROR_LOG_ACTION_CHKFW	(1 << (53-32))
>   #define OCXL_PMEM_ERROR_LOG_ACTION_REPLACE	(1 << (54-32))
> @@ -66,6 +88,11 @@ struct ioctl_ocxl_pmem_controller_stats {
>   	__u64 cache_write_latency; /* nanoseconds */
>   };
>   
> +struct ioctl_ocxl_pmem_mmio {
> +	__u64 address; /* Offset in global MMIO space */
> +	__u64 val; /* value to write/was read */
> +};
> +
>   struct ioctl_ocxl_pmem_eventfd {
>   	__s32 eventfd;
>   	__u32 reserved;
> @@ -92,4 +119,9 @@ struct ioctl_ocxl_pmem_eventfd {
>   #define IOCTL_OCXL_PMEM_EVENT_CHECK			_IOR(OCXL_PMEM_MAGIC, 0x07, __u64)
>   #define IOCTL_OCXL_PMEM_REQUEST_HEALTH			_IO(OCXL_PMEM_MAGIC, 0x08)
>   
> +#define IOCTL_OCXL_PMEM_FWDEBUG		_IOWR(OCXL_PMEM_MAGIC, 0xf0, struct ioctl_ocxl_pmem_fwdebug)
> +#define IOCTL_OCXL_PMEM_MMIO_WRITE	_IOW(OCXL_PMEM_MAGIC, 0xf1, struct ioctl_ocxl_pmem_mmio)
> +#define IOCTL_OCXL_PMEM_MMIO_READ	_IOWR(OCXL_PMEM_MAGIC, 0xf2, struct ioctl_ocxl_pmem_mmio)
> +#define IOCTL_OCXL_PMEM_SHUTDOWN	_IO(OCXL_PMEM_MAGIC, 0xf3)
> +
>   #endif /* _UAPI_OCXL_SCM_H */
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
