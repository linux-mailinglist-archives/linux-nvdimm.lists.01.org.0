Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817951ED5EA
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jun 2020 20:12:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77B6B100A52E5;
	Wed,  3 Jun 2020 11:07:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1C747100A52E4
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 11:07:28 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053I3gi7020818;
	Wed, 3 Jun 2020 14:11:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31d2u357bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 14:11:52 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 053I3glU020870;
	Wed, 3 Jun 2020 14:11:52 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31d2u357ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 14:11:52 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 053IAm73030111;
	Wed, 3 Jun 2020 18:11:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma01fra.de.ibm.com with ESMTP id 31bf47ug2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 18:11:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 053IBlM256098974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2020 18:11:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4C504C046;
	Wed,  3 Jun 2020 18:11:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 765774C04A;
	Wed,  3 Jun 2020 18:11:43 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.71.48])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2020 18:11:43 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 03 Jun 2020 23:41:42 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v9 4/5] ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
In-Reply-To: <20200602205148.GF1505637@iweiny-DESK2.sc.intel.com>
References: <20200602101438.73929-1-vaibhav@linux.ibm.com> <20200602101438.73929-5-vaibhav@linux.ibm.com> <20200602205148.GF1505637@iweiny-DESK2.sc.intel.com>
Date: Wed, 03 Jun 2020 23:41:42 +0530
Message-ID: <87tuzsggtd.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_13:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030136
Message-ID-Hash: BVMVRRJVWV2PNTGR3ZMI75KO7ZT76KL4
X-Message-ID-Hash: BVMVRRJVWV2PNTGR3ZMI75KO7ZT76KL4
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BVMVRRJVWV2PNTGR3ZMI75KO7ZT76KL4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ira,

Thanks for reviewing this patch. My responses below:

Ira Weiny <ira.weiny@intel.com> writes:

> On Tue, Jun 02, 2020 at 03:44:37PM +0530, Vaibhav Jain wrote:
>> Introduce support for PAPR NVDIMM Specific Methods (PDSM) in papr_scm
>> module and add the command family NVDIMM_FAMILY_PAPR to the white list
>> of NVDIMM command sets. Also advertise support for ND_CMD_CALL for the
>> nvdimm command mask and implement necessary scaffolding in the module
>> to handle ND_CMD_CALL ioctl and PDSM requests that we receive.
>> 
>> The layout of the PDSM request as we expect from libnvdimm/libndctl is
>> described in newly introduced uapi header 'papr_pdsm.h' which
>> defines a new 'struct nd_pdsm_cmd_pkg' header. This header is used
>> to communicate the PDSM request via member
>> 'nd_cmd_pkg.nd_command' and size of payload that need to be
>> sent/received for servicing the PDSM.
>> 
>> A new function is_cmd_valid() is implemented that reads the args to
>> papr_scm_ndctl() and performs sanity tests on them. A new function
>> papr_scm_service_pdsm() is introduced and is called from
>> papr_scm_ndctl() in case of a PDSM request is received via ND_CMD_CALL
>> command from libnvdimm.
>> 
>> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>> 
>> Resend:
>> * Added ack from Aneesh.
>> 
>> v8..v9:
>> * Reduced the usage of term SCM replacing it with appropriate
>>   replacement [ Dan Williams, Aneesh ]
>> * Renamed 'papr_scm_pdsm.h' to 'papr_pdsm.h'
>> * s/PAPR_SCM_PDSM_*/PAPR_PDSM_*/g
>> * s/NVDIMM_FAMILY_PAPR_SCM/NVDIMM_FAMILY_PAPR/g
>> * Minor updates to 'papr_psdm.h' to replace usage of term 'SCM'.
>> * Minor update to patch description.
>> 
>> v7..v8:
>> * Removed the 'payload_offset' field from 'struct
>>   nd_pdsm_cmd_pkg'. Instead command payload is always assumed to start
>>   at 'nd_pdsm_cmd_pkg.payload'. [ Aneesh ]
>> * To enable introducing new fields to 'struct nd_pdsm_cmd_pkg',
>>   'reserved' field of 10-bytes is introduced. [ Aneesh ]
>> * Fixed a typo in "Backward Compatibility" section of papr_scm_pdsm.h
>>   [ Ira ]
>> 
>> Resend:
>> * None
>> 
>> v6..v7 :
>> * Removed the re-definitions of __packed macro from papr_scm_pdsm.h
>>   [Mpe].
>> * Removed the usage of __KERNEL__ macros in papr_scm_pdsm.h [Mpe].
>> * Removed macros that were unused in papr_scm.c from papr_scm_pdsm.h
>>   [Mpe].
>> * Made functions defined in papr_scm_pdsm.h as static inline. [Mpe]
>> 
>> v5..v6 :
>> * Changed the usage of the term DSM to PDSM to distinguish it from the
>>   ACPI term [ Dan Williams ]
>> * Renamed papr_scm_dsm.h to papr_scm_pdsm.h and updated various struct
>>   to reflect the new terminology.
>> * Updated the patch description and title to reflect the new terminology.
>> * Squashed patch to introduce new command family in 'ndctl.h' with
>>   this patch [ Dan Williams ]
>> * Updated the papr_scm_pdsm method starting index from 0x10000 to 0x0
>>   [ Dan Williams ]
>> * Removed redundant license text from the papr_scm_psdm.h file.
>>   [ Dan Williams ]
>> * s/envelop/envelope/ at various places [ Dan Williams ]
>> * Added '__packed' attribute to command package header to gaurd
>>   against different compiler adding paddings between the fields.
>>   [ Dan Williams]
>> * Converted various pr_debug to dev_debug [ Dan Williams ]
>> 
>> v4..v5 :
>> * None
>> 
>> v3..v4 :
>> * None
>> 
>> v2..v3 :
>> * Updated the patch prefix to 'ndctl/uapi' [Aneesh]
>> 
>> v1..v2 :
>> * None
>> ---
>>  arch/powerpc/include/uapi/asm/papr_pdsm.h | 136 ++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/papr_scm.c | 101 +++++++++++++++-
>>  include/uapi/linux/ndctl.h                |   1 +
>>  3 files changed, 232 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/powerpc/include/uapi/asm/papr_pdsm.h
>> 
>> diff --git a/arch/powerpc/include/uapi/asm/papr_pdsm.h b/arch/powerpc/include/uapi/asm/papr_pdsm.h
>> new file mode 100644
>> index 000000000000..6407fefcc007
>> --- /dev/null
>> +++ b/arch/powerpc/include/uapi/asm/papr_pdsm.h
>> @@ -0,0 +1,136 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>> +/*
>> + * PAPR nvDimm Specific Methods (PDSM) and structs for libndctl
>> + *
>> + * (C) Copyright IBM 2020
>> + *
>> + * Author: Vaibhav Jain <vaibhav at linux.ibm.com>
>> + */
>> +
>> +#ifndef _UAPI_ASM_POWERPC_PAPR_PDSM_H_
>> +#define _UAPI_ASM_POWERPC_PAPR_PDSM_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * PDSM Envelope:
>> + *
>> + * The ioctl ND_CMD_CALL transfers data between user-space and kernel via
>> + * envelope which consists of a header and user-defined payload sections.
>> + * The header is described by 'struct nd_pdsm_cmd_pkg' which expects a
>> + * payload following it and accessible via 'nd_pdsm_cmd_pkg.payload' field.
>> + * There is reserved field that can used to introduce new fields to the
>> + * structure in future. It also tries to ensure that 'nd_pdsm_cmd_pkg.payload'
>> + * lies at a 8-byte boundary.
>> + *
>> + *  +-------------+---------------------+---------------------------+
>> + *  |   64-Bytes  |       16-Bytes      |       Max 176-Bytes       |
>> + *  +-------------+---------------------+---------------------------+
>> + *  |               nd_pdsm_cmd_pkg     |                           |
>> + *  |-------------+                     |                           |
>> + *  |  nd_cmd_pkg |                     |                           |
>> + *  +-------------+---------------------+---------------------------+
>> + *  | nd_family   |                     |                           |
>> + *  | nd_size_out | cmd_status          |                           |
>> + *  | nd_size_in  | payload_version     |     payload               |
>> + *  | nd_command  | reserved            |                           |
>> + *  | nd_fw_size  |                     |                           |
>> + *  +-------------+---------------------+---------------------------+
>> + *
>> + * PDSM Header:
>> + *
>> + * The header is defined as 'struct nd_pdsm_cmd_pkg' which embeds a
>> + * 'struct nd_cmd_pkg' instance. The PDSM command is assigned to member
>> + * 'nd_cmd_pkg.nd_command'. Apart from size information of the envelope which is
>> + * contained in 'struct nd_cmd_pkg', the header also has members following 
>                                                              ^^^^^
>                                                         ...  the  ...
Thanks for catching this will get it fixed.
>
>> + * members:
>> + *
>> + * 'cmd_status'		: (Out) Errors if any encountered while servicing PDSM.
>> + * 'payload_version'	: (In/Out) Version number associated with the payload.
>> + * 'reserved'		: Not used and reserved for future.
>> + *
>> + * PDSM Payload:
>> + *
>> + * The layout of the PDSM Payload is defined by various structs shared between
>> + * papr_scm and libndctl so that contents of payload can be interpreted. During
>> + * servicing of a PDSM the papr_scm module will read input args from the payload
>> + * field by casting its contents to an appropriate struct pointer based on the
>> + * PDSM command. Similarly the output of servicing the PDSM command will be
>> + * copied to the payload field using the same struct.
>> + *
>> + * 'libnvdimm' enforces a hard limit of 256 bytes on the envelope size, which
>> + * leaves around 176 bytes for the envelope payload (ignoring any padding that
>> + * the compiler may silently introduce).
>> + *
>> + * Payload Version:
>> + *
>> + * A 'payload_version' field is present in PDSM header that indicates a specific
>> + * version of the structure present in PDSM Payload for a given PDSM command.
>> + * This provides backward compatibility in case the PDSM Payload structure
>> + * evolves and different structures are supported by 'papr_scm' and 'libndctl'.
>> + *
>> + * When sending a PDSM Payload to 'papr_scm', 'libndctl' should send the version
>> + * of the payload struct it supports via 'payload_version' field. The 'papr_scm'
>> + * module when servicing the PDSM envelope checks the 'payload_version' and then
>> + * uses 'payload struct version' == MIN('payload_version field',
>> + * 'max payload-struct-version supported by papr_scm') to service the PDSM.
>> + * After servicing the PDSM, 'papr_scm' put the negotiated version of payload
>> + * struct in returned 'payload_version' field.
>> + *
>> + * Libndctl on receiving the envelope back from papr_scm again checks the
>> + * 'payload_version' field and based on it use the appropriate version dsm
>> + * struct to parse the results.
>> + *
>> + * Backward Compatibility:
>> + *
>> + * Above scheme of exchanging different versioned PDSM struct between libndctl
>> + * and papr_scm should provide backward compatibility until following two
>> + * assumptions/conditions when defining new PDSM structs hold:
>> + *
>> + * Let T(X) = { set of attributes in PDSM struct 'T' versioned X }
>> + *
>> + * 1. T(X) is a proper subset of T(Y) if Y > X.
>> + *    i.e Each new version of PDSM struct should retain existing struct
>> + *    attributes from previous version
>> + *
>> + * 2. If an entity (libndctl or papr_scm) supports a PDSM struct T(X) then
>> + *    it should also support T(1), T(2)...T(X - 1).
>> + *    i.e When adding support for new version of a PDSM struct, libndctl
>> + *    and papr_scm should retain support of the existing PDSM struct
>> + *    version they support.
>
> Please see this thread for an example why versions are a bad idea in UAPIs:
>
> https://lkml.org/lkml/2020/3/26/213
>

> While the use of version is different in that thread the fundamental issues are
> the same.  You end up with some weird matrix of supported features and
> structure definitions.  For example, you are opening up the possibility of
> changing structures with a different version for no good reason.

Not really sure I understand the statement correctly "you are opening up
the possibility of changing structures with a different version for no
good reason."
We want to return more data in the struct in future iterations. So
'changing structure with different version' is something we are
expecting. 

With the backward compatibility constraints 1 & 2 above, it will ensure
that support matrix looks like a lower traingular matrix with each
successive version supporting previous version attributes. So supporting
future versions is relatively simplified.

>
> Also having the user query with version Z and get back version X (older) is
> odd.  Generally if the kernel does not know about a feature (ie version Z of
> the structure) it should return -EINVAL and let the user figure out what to do.
> The user may just give up or they could try a different query.
>
Considering the flow of ndctl/libndctl this is needed. libndctl will
usually issues only one CMD_CALL ioctl to kernel and if that fails then
an error is reported and ndctl will exit loosing state.

Adding mechanism in libndctl to reissue CMD_CALL ioctl to fetch a
appropriate version of pdsm struct is going to be considerably more
work.

This version fall-back mechanism, ensures that libndctl will receive
usable data without having to reissue a more CMD_CALL ioctls.

>> + */
>> +
>> +/* PDSM-header + payload expected with ND_CMD_CALL ioctl from libnvdimm */
>> +struct nd_pdsm_cmd_pkg {
>> +	struct nd_cmd_pkg hdr;	/* Package header containing sub-cmd */
>> +	__s32 cmd_status;	/* Out: Sub-cmd status returned back */
>> +	__u16 reserved[5];	/* Ignored and to be used in future */
>
> How do you know when reserved is used for something else in the future?  Is
> reserved guaranteed (and checked by the code) to be 0?

For current set of pdsm requests ignore these reserved fields. However a
future pdsm request can leverage these reserved fields. So papr_scm
just bind the usage of these fields with the value of
'nd_cmd_pkg.nd_command' that indicates the pdsm request.

That being said checking if the reserved fields are set to 0 will be a
good measure. Will add this check in next iteration.

>
>> +	__u16 payload_version;	/* In/Out: version of the payload */
>
> Why is payload_version after reserved?
Want to place the payload version field just before the payload data so
that it can be accessed with simple pointer arithmetic.

>
>> +	__u8 payload[];		/* In/Out: Sub-cmd data buffer */
>> +} __packed;
>> +
>> +/*
>> + * Methods to be embedded in ND_CMD_CALL request. These are sent to the kernel
>> + * via 'nd_pdsm_cmd_pkg.hdr.nd_command' member of the ioctl struct
>> + */
>> +enum papr_pdsm {
>> +	PAPR_PDSM_MIN = 0x0,
>> +	PAPR_PDSM_MAX,
>> +};
>> +
>> +/* Convert a libnvdimm nd_cmd_pkg to pdsm specific pkg */
>> +static inline struct nd_pdsm_cmd_pkg *nd_to_pdsm_cmd_pkg(struct nd_cmd_pkg *cmd)
>> +{
>> +	return (struct nd_pdsm_cmd_pkg *) cmd;
>> +}
>> +
>> +/* Return the payload pointer for a given pcmd */
>> +static inline void *pdsm_cmd_to_payload(struct nd_pdsm_cmd_pkg *pcmd)
>> +{
>> +	if (pcmd->hdr.nd_size_in == 0 && pcmd->hdr.nd_size_out == 0)
>> +		return NULL;
>> +	else
>> +		return (void *)(pcmd->payload);
>> +}
>> +
>> +#endif /* _UAPI_ASM_POWERPC_PAPR_PDSM_H_ */
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> index 149431594839..5e2237e7ec08 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -15,13 +15,15 @@
>>  #include <linux/seq_buf.h>
>>  
>>  #include <asm/plpar_wrappers.h>
>> +#include <asm/papr_pdsm.h>
>>  
>>  #define BIND_ANY_ADDR (~0ul)
>>  
>>  #define PAPR_SCM_DIMM_CMD_MASK \
>>  	((1ul << ND_CMD_GET_CONFIG_SIZE) | \
>>  	 (1ul << ND_CMD_GET_CONFIG_DATA) | \
>> -	 (1ul << ND_CMD_SET_CONFIG_DATA))
>> +	 (1ul << ND_CMD_SET_CONFIG_DATA) | \
>> +	 (1ul << ND_CMD_CALL))
>>  
>>  /* DIMM health bitmap bitmap indicators */
>>  /* SCM device is unable to persist memory contents */
>> @@ -350,16 +352,97 @@ static int papr_scm_meta_set(struct papr_scm_priv *p,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Validate the inputs args to dimm-control function and return '0' if valid.
>> + * This also does initial sanity validation to ND_CMD_CALL sub-command packages.
>> + */
>> +static int is_cmd_valid(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
>> +		       unsigned int buf_len)
>> +{
>> +	unsigned long cmd_mask = PAPR_SCM_DIMM_CMD_MASK;
>> +	struct nd_pdsm_cmd_pkg *pkg = nd_to_pdsm_cmd_pkg(buf);
>> +	struct papr_scm_priv *p;
>> +
>> +	/* Only dimm-specific calls are supported atm */
>> +	if (!nvdimm)
>> +		return -EINVAL;
>> +
>> +	/* get the provider date from struct nvdimm */
>
> s/date/data
Thanks for point this out. Will fix this in next iteration.

>
>> +	p = nvdimm_provider_data(nvdimm);
>> +
>> +	if (!test_bit(cmd, &cmd_mask)) {
>> +		dev_dbg(&p->pdev->dev, "Unsupported cmd=%u\n", cmd);
>> +		return -EINVAL;
>> +	} else if (cmd == ND_CMD_CALL) {
>> +
>> +		/* Verify the envelope package */
>> +		if (!buf || buf_len < sizeof(struct nd_pdsm_cmd_pkg)) {
>> +			dev_dbg(&p->pdev->dev, "Invalid pkg size=%u\n",
>> +				buf_len);
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* Verify that the PDSM family is valid */
>> +		if (pkg->hdr.nd_family != NVDIMM_FAMILY_PAPR) {
>> +			dev_dbg(&p->pdev->dev, "Invalid pkg family=0x%llx\n",
>> +				pkg->hdr.nd_family);
>> +			return -EINVAL;
>> +
>> +		}
>> +
>> +		/* We except a payload with all PDSM commands */
>> +		if (pdsm_cmd_to_payload(pkg) == NULL) {
>> +			dev_dbg(&p->pdev->dev,
>> +				"Empty payload for sub-command=0x%llx\n",
>> +				pkg->hdr.nd_command);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	/* Command looks valid */
>
> I assume the first command to be implemented also checks the { nd_command,
> payload_version, payload length } for correctness?
Yes the pdsm service functions do check the payload_version and
payload_length. Please see the papr_pdsm_health() that services the
PAPR_PDSM_HEALTH pdsm in Patch-5

>
>> +	return 0;
>> +}
>> +
>> +static int papr_scm_service_pdsm(struct papr_scm_priv *p,
>> +				struct nd_pdsm_cmd_pkg *call_pkg)
>> +{
>> +	/* unknown subcommands return error in packages */
>> +	if (call_pkg->hdr.nd_command <= PAPR_PDSM_MIN ||
>> +	    call_pkg->hdr.nd_command >= PAPR_PDSM_MAX) {
>> +		dev_dbg(&p->pdev->dev, "Invalid PDSM request 0x%llx\n",
>> +			call_pkg->hdr.nd_command);
>> +		call_pkg->cmd_status = -EINVAL;
>> +		return 0;
>> +	}
>> +
>> +	/* Depending on the DSM command call appropriate service routine */
>> +	switch (call_pkg->hdr.nd_command) {
>> +	default:
>> +		dev_dbg(&p->pdev->dev, "Unsupported PDSM request 0x%llx\n",
>> +			call_pkg->hdr.nd_command);
>> +		call_pkg->cmd_status = -ENOENT;
>> +		return 0;
>> +	}
>> +}
>> +
>>  static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>>  			  struct nvdimm *nvdimm, unsigned int cmd, void *buf,
>>  			  unsigned int buf_len, int *cmd_rc)
>>  {
>>  	struct nd_cmd_get_config_size *get_size_hdr;
>>  	struct papr_scm_priv *p;
>> +	struct nd_pdsm_cmd_pkg *call_pkg = NULL;
>> +	int rc;
>>  
>> -	/* Only dimm-specific calls are supported atm */
>> -	if (!nvdimm)
>> -		return -EINVAL;
>> +	/* Use a local variable in case cmd_rc pointer is NULL */
>> +	if (cmd_rc == NULL)
>> +		cmd_rc = &rc;
>
> Why is this needed?  AFAICT The caller of papr_scm_ndctl does not specify null
> and you did not change it.
This pointer is coming from outside the papr_scm code hence need to be
defensive here. Also as per[1] cmd_rc is "translation of firmware status"
and not every caller would need it hence making this pointer optional.

This is evident in acpi_nfit_blk_get_flags() where the 'nd_desc->ndctl'
is called with 'cmd_rc == NULL'.

[1] https://lore.kernel.org/linux-nvdimm/CAPcyv4hE_FG0YZXJVA1G=CBq8b9e0K54jxk5Sq5UKU-dnWT2Kg@mail.gmail.com/

>
>> +
>> +	*cmd_rc = is_cmd_valid(nvdimm, cmd, buf, buf_len);
>> +	if (*cmd_rc) {
>> +		pr_debug("Invalid cmd=0x%x. Err=%d\n", cmd, *cmd_rc);
>> +		return *cmd_rc;
>> +	}
>>  
>>  	p = nvdimm_provider_data(nvdimm);
>>  
>> @@ -381,13 +464,19 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>>  		*cmd_rc = papr_scm_meta_set(p, buf);
>>  		break;
>>  
>> +	case ND_CMD_CALL:
>> +		call_pkg = nd_to_pdsm_cmd_pkg(buf);
>> +		*cmd_rc = papr_scm_service_pdsm(p, call_pkg);
>> +		break;
>> +
>>  	default:
>> -		return -EINVAL;
>> +		dev_dbg(&p->pdev->dev, "Unknown command = %d\n", cmd);
>> +		*cmd_rc = -EINVAL;
>
> Is this change related?  If there is a bug where there is a caller of
> papr_scm_ndctl() with cmd_rc == NULL this should be a separate patch to fix
> that issue.
This simplifies a bit debugging of errors reported in
papr_scm_ndctl() as it ensures that subsequest dev_dbg "Returned with
cmd_rc" is always logged.

I think, this is a too small change to be carved out as an independent
patch. Also this doesnt change the behaviour of the code except logging
some more error info.

However, If you feel too strongly about it I will spin a separate patch
in this patch series for this.

>
> Ira
>
>>  	}
>>  
>>  	dev_dbg(&p->pdev->dev, "returned with cmd_rc = %d\n", *cmd_rc);
>>  
>> -	return 0;
>> +	return *cmd_rc;
>>  }
>>  
>>  static ssize_t flags_show(struct device *dev,
>> diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
>> index de5d90212409..0e09dc5cec19 100644
>> --- a/include/uapi/linux/ndctl.h
>> +++ b/include/uapi/linux/ndctl.h
>> @@ -244,6 +244,7 @@ struct nd_cmd_pkg {
>>  #define NVDIMM_FAMILY_HPE2 2
>>  #define NVDIMM_FAMILY_MSFT 3
>>  #define NVDIMM_FAMILY_HYPERV 4
>> +#define NVDIMM_FAMILY_PAPR 5
>>  
>>  #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
>>  					struct nd_cmd_pkg)
>> -- 
>> 2.26.2
>> 

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
