Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DA179CF0
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Mar 2020 01:46:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1952910FC36F5;
	Wed,  4 Mar 2020 16:47:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8529510FC36F0
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 16:47:33 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0250dQia052321
	for <linux-nvdimm@lists.01.org>; Wed, 4 Mar 2020 19:46:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yhukmu1jj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 04 Mar 2020 19:46:40 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Thu, 5 Mar 2020 00:46:38 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 5 Mar 2020 00:46:30 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0250jVxY44957954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2020 00:45:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90524A404D;
	Thu,  5 Mar 2020 00:46:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFE3CA4040;
	Thu,  5 Mar 2020 00:46:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  5 Mar 2020 00:46:28 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D831CA0264;
	Thu,  5 Mar 2020 11:46:23 +1100 (AEDT)
Subject: Re: [PATCH v3 19/27] powerpc/powernv/pmem: Add an IOCTL to report
 controller statistics
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-20-alastair@au1.ibm.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Thu, 5 Mar 2020 11:46:27 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-20-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030500-0020-0000-0000-000003B09316
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030500-0021-0000-0000-00002208CBFC
Message-Id: <c0002b11-7f54-38d3-4ae2-9008a5cc0b61@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_10:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003050001
Message-ID-Hash: CEEZIRNW3Z3OQFB6QZPBNAJCOA2WTQVM
X-Message-ID-Hash: CEEZIRNW3Z3OQFB6QZPBNAJCOA2WTQVM
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc
 -dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CEEZIRNW3Z3OQFB6QZPBNAJCOA2WTQVM/>
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
> The controller can report a number of statistics that are useful
> in evaluating the performance and reliability of the card.
> 
> This patch exposes this information via an IOCTL.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/platforms/powernv/pmem/ocxl.c | 185 +++++++++++++++++++++
>   include/uapi/nvdimm/ocxl-pmem.h            |  17 ++
>   2 files changed, 202 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> index 2cabafe1fc58..009d4fd29e7d 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> @@ -758,6 +758,186 @@ static int ioctl_controller_dump_complete(struct ocxlpmem *ocxlpmem)
>   				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED);
>   }
>   
> +/**
> + * controller_stats_header_parse() - Parse the first 64 bits of the controller stats admin command response
> + * @ocxlpmem: the device metadata
> + * @length: out, returns the number of bytes in the response (excluding the 64 bit header)
> + */
> +static int controller_stats_header_parse(struct ocxlpmem *ocxlpmem,
> +	u32 *length)
> +{
> +	int rc;
> +	u64 val;
> +
> +	u16 data_identifier;
> +	u32 data_length;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	data_identifier = val >> 48;
> +	data_length = val & 0xFFFFFFFF;
> +
> +	if (data_identifier != 0x4353) { // 'CS'
> +		dev_err(&ocxlpmem->dev,
> +			"Bad data identifier for controller stats, expected 'CS', got '%-.*s'\n",
> +			2, (char *)&data_identifier);
> +		return -EINVAL;

Same comment as earlier patches re EINVAL

> +	}
> +
> +	*length = data_length;
> +	return 0;
> +}
> +
> +static int ioctl_controller_stats(struct ocxlpmem *ocxlpmem,
> +				  struct ioctl_ocxl_pmem_controller_stats __user *uarg)
> +{
> +	struct ioctl_ocxl_pmem_controller_stats args;
> +	u32 length;
> +	int rc;
> +	u64 val;
> +
> +	memset(&args, '\0', sizeof(args));
> +
> +	mutex_lock(&ocxlpmem->admin_command.lock);
> +
> +	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_CONTROLLER_STATS);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> +				      ocxlpmem->admin_command.request_offset + 0x08,
> +				      OCXL_LITTLE_ENDIAN, 0);
> +	if (rc)
> +		goto out;
> +
> +	rc = admin_command_execute(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +
> +	rc = admin_command_complete_timeout(ocxlpmem,
> +					    ADMIN_COMMAND_CONTROLLER_STATS);
> +	if (rc < 0) {
> +		dev_warn(&ocxlpmem->dev, "Controller stats timed out\n");
> +		goto out;
> +	}
> +
> +	rc = admin_response(ocxlpmem);
> +	if (rc < 0)
> +		goto out;
> +	if (rc != STATUS_SUCCESS) {
> +		warn_status(ocxlpmem,
> +			    "Unexpected status from controller stats", rc);
> +		goto out;
> +	}
> +
> +	rc = controller_stats_header_parse(ocxlpmem, &length);
> +	if (rc)
> +		goto out;
> +
> +	if (length != 0x140)
> +		warn_status(ocxlpmem,
> +			    "Unexpected length for controller stats data, expected 0x140, got 0x%x",
> +			    length);

Might be worth a comment to explain where 0x140 comes from (it looks 
correct from my reading of the spec)

> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x08,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		goto out;
> +
> +	args.reset_count = val >> 32;
> +	args.reset_uptime = val & 0xFFFFFFFF;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x10,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		goto out;
> +
> +	args.power_on_uptime = val >> 32;

We're not collecting life remaining?

> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x08,
> +				     OCXL_LITTLE_ENDIAN, &args.host_load_count);

My reading of the spec says HLC is at +0x10

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x10,
> +				     OCXL_LITTLE_ENDIAN, &args.host_store_count);

HSC at +0x18

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x18,
> +				     OCXL_LITTLE_ENDIAN, &args.media_read_count);

MRC is at +0x50

And you're missing CRU, HLD, HSD

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x20,
> +				     OCXL_LITTLE_ENDIAN, &args.media_write_count);

MWC at +0x58

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x28,
> +				     OCXL_LITTLE_ENDIAN, &args.cache_hit_count);

CRHC at +0x90

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x30,
> +				     OCXL_LITTLE_ENDIAN, &args.cache_miss_count);

This field doesn't seem to exist at all in my copy of the spec

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x38,
> +				     OCXL_LITTLE_ENDIAN, &args.media_read_latency);

Nor this one

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x40,
> +				     OCXL_LITTLE_ENDIAN, &args.media_write_latency);

Nor this one

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x48,
> +				     OCXL_LITTLE_ENDIAN, &args.cache_read_latency);

Nor this one

> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x50,
> +				     OCXL_LITTLE_ENDIAN, &args.cache_write_latency);

Nor this one

> +	if (rc)
> +		goto out;
> +
> +	if (copy_to_user(uarg, &args, sizeof(args))) {
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +
> +	rc = admin_response_handled(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +	rc = 0;
> +	goto out;

Per Fred this pattern isn't common in the kernel, but perhaps this is 
just personal taste

> +
> +out:
> +	mutex_unlock(&ocxlpmem->admin_command.lock);
> +	return rc;
> +}
> +
>   static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
>   {
>   	struct ocxlpmem *ocxlpmem = file->private_data;
> @@ -781,6 +961,11 @@ static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
>   	case IOCTL_OCXL_PMEM_CONTROLLER_DUMP_COMPLETE:
>   		rc = ioctl_controller_dump_complete(ocxlpmem);
>   		break;
> +
> +	case IOCTL_OCXL_PMEM_CONTROLLER_STATS:
> +		rc = ioctl_controller_stats(ocxlpmem,
> +					    (struct ioctl_ocxl_pmem_controller_stats __user *)args);
> +		break;
>   	}
>   
>   	return rc;
> diff --git a/include/uapi/nvdimm/ocxl-pmem.h b/include/uapi/nvdimm/ocxl-pmem.h
> index d4d8512d03f7..add223aa2fdb 100644
> --- a/include/uapi/nvdimm/ocxl-pmem.h
> +++ b/include/uapi/nvdimm/ocxl-pmem.h
> @@ -50,6 +50,22 @@ struct ioctl_ocxl_pmem_controller_dump_data {
>   	__u64 reserved[8];
>   };
>   
> +struct ioctl_ocxl_pmem_controller_stats {
> +	__u32 reset_count;
> +	__u32 reset_uptime; /* seconds */
> +	__u32 power_on_uptime; /* seconds */
> +	__u64 host_load_count;
> +	__u64 host_store_count;
> +	__u64 media_read_count;
> +	__u64 media_write_count;
> +	__u64 cache_hit_count;
> +	__u64 cache_miss_count;
> +	__u64 media_read_latency; /* nanoseconds */
> +	__u64 media_write_latency; /* nanoseconds */
> +	__u64 cache_read_latency; /* nanoseconds */
> +	__u64 cache_write_latency; /* nanoseconds */
> +};
> +
>   /* ioctl numbers */
>   #define OCXL_PMEM_MAGIC 0x5C
>   /* SCM devices */
> @@ -57,5 +73,6 @@ struct ioctl_ocxl_pmem_controller_dump_data {
>   #define IOCTL_OCXL_PMEM_CONTROLLER_DUMP			_IO(OCXL_PMEM_MAGIC, 0x02)
>   #define IOCTL_OCXL_PMEM_CONTROLLER_DUMP_DATA		_IOWR(OCXL_PMEM_MAGIC, 0x03, struct ioctl_ocxl_pmem_controller_dump_data)
>   #define IOCTL_OCXL_PMEM_CONTROLLER_DUMP_COMPLETE	_IO(OCXL_PMEM_MAGIC, 0x04)
> +#define IOCTL_OCXL_PMEM_CONTROLLER_STATS		_IO(OCXL_PMEM_MAGIC, 0x05)
>   
>   #endif /* _UAPI_OCXL_SCM_H */
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
