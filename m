Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6FA1F0682
	for <lists+linux-nvdimm@lfdr.de>; Sat,  6 Jun 2020 14:34:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91DBD10112D73;
	Sat,  6 Jun 2020 05:34:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ACF3B100EAB1B
	for <linux-nvdimm@lists.01.org>; Sat,  6 Jun 2020 05:34:52 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 056CVhF3045555;
	Sat, 6 Jun 2020 08:34:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31g74rm7u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2020 08:34:21 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 056CVmMa045784;
	Sat, 6 Jun 2020 08:34:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31g74rm7tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2020 08:34:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 056CEuBI032311;
	Sat, 6 Jun 2020 12:34:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 31g2s7rmv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2020 12:34:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 056CYHuV36897016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Jun 2020 12:34:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 565A2A405B;
	Sat,  6 Jun 2020 12:34:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48D65A4060;
	Sat,  6 Jun 2020 12:34:13 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.98])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Sat,  6 Jun 2020 12:34:13 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Sat, 06 Jun 2020 18:04:12 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 6/6] powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH
In-Reply-To: <20200605183655.GP1505637@iweiny-DESK2.sc.intel.com>
References: <20200604234136.253703-1-vaibhav@linux.ibm.com> <20200604234136.253703-7-vaibhav@linux.ibm.com> <20200605183655.GP1505637@iweiny-DESK2.sc.intel.com>
Date: Sat, 06 Jun 2020 18:04:11 +0530
Message-ID: <87wo4kfk58.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-06_07:2020-06-04,2020-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 adultscore=0 priorityscore=1501 suspectscore=1
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006060098
Message-ID-Hash: JEL3PUFI7ZYHWWWO7AIWRPJIUHJIAEFD
X-Message-ID-Hash: JEL3PUFI7ZYHWWWO7AIWRPJIUHJIAEFD
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JEL3PUFI7ZYHWWWO7AIWRPJIUHJIAEFD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:

> On Fri, Jun 05, 2020 at 05:11:36AM +0530, Vaibhav Jain wrote:
>> This patch implements support for PDSM request 'PAPR_PDSM_HEALTH'
>> that returns a newly introduced 'struct nd_papr_pdsm_health' instance
>> containing dimm health information back to user space in response to
>> ND_CMD_CALL. This functionality is implemented in newly introduced
>> papr_pdsm_health() that queries the nvdimm health information and
>> then copies this information to the package payload whose layout is
>> defined by 'struct nd_papr_pdsm_health'.
>> 
>> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>> 
>> v9..v10:
>> * Removed code in papr_pdsm_health that performed validation on pdsm
>>   payload version and corrosponding struct and defines used for
>>   validation of payload version.
>> * Dropped usage of struct papr_pdsm_health in 'struct
>>   papr_scm_priv'. Instead papr_psdm_health() now uses
>>   'papr_scm_priv.health_bitmap' to populate the pdsm payload.
>> * Above change also fixes the problem where this patch was removing
>>   the code that was previously introduced in this patch-series.
>>   [ Ira ]
>> * Introduced a new def ND_PDSM_ENVELOPE_HDR_SIZE that indicates the
>>   space allocated to 'struct nd_pdsm_cmd_pkg' fields except 'struct
>>   nd_cmd_pkg'. This def is useful in validating payload sizes.
>> * Reworked papr_pdsm_health() to enforce a specific payload size for
>>   'PAPR_PDSM_HEALTH' pdsm request.
>> 
>> Resend:
>> * Added ack from Aneesh.
>> 
>> v8..v9:
>> * s/PAPR_SCM_PDSM_HEALTH/PAPR_PDSM_HEALTH/g  [ Dan , Aneesh ]
>> * s/PAPR_SCM_PSDM_DIMM_*/PAPR_PDSM_DIMM_*/g
>> * Renamed papr_scm_get_health() to papr_psdm_health()
>> * Updated patch description to replace papr-scm dimm with nvdimm.
>> 
>> v7..v8:
>> * None
>> 
>> Resend:
>> * None
>> 
>> v6..v7:
>> * Updated flags_show() to use seq_buf_printf(). [Mpe]
>> * Updated papr_scm_get_health() to use newly introduced
>>   __drc_pmem_query_health() bypassing the cache [Mpe].
>> 
>> v5..v6:
>> * Added attribute '__packed' to 'struct nd_papr_pdsm_health_v1' to
>>   gaurd against possibility of different compilers adding different
>>   paddings to the struct [ Dan Williams ]
>> 
>> * Updated 'struct nd_papr_pdsm_health_v1' to use __u8 instead of
>>   'bool' and also updated drc_pmem_query_health() to take this into
>>   account. [ Dan Williams ]
>> 
>> v4..v5:
>> * None
>> 
>> v3..v4:
>> * Call the DSM_PAPR_SCM_HEALTH service function from
>>   papr_scm_service_dsm() instead of papr_scm_ndctl(). [Aneesh]
>> 
>> v2..v3:
>> * Updated struct nd_papr_scm_dimm_health_stat_v1 to use '__xx' types
>>   as its exported to the userspace [Aneesh]
>> * Changed the constants DSM_PAPR_SCM_DIMM_XX indicating dimm health
>>   from enum to #defines [Aneesh]
>> 
>> v1..v2:
>> * New patch in the series
>> ---
>>  arch/powerpc/include/uapi/asm/papr_pdsm.h | 33 +++++++++++
>>  arch/powerpc/platforms/pseries/papr_scm.c | 70 +++++++++++++++++++++++
>>  2 files changed, 103 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/uapi/asm/papr_pdsm.h b/arch/powerpc/include/uapi/asm/papr_pdsm.h
>> index 8b1a4f8fa316..c4c990ede5d4 100644
>> --- a/arch/powerpc/include/uapi/asm/papr_pdsm.h
>> +++ b/arch/powerpc/include/uapi/asm/papr_pdsm.h
>> @@ -71,12 +71,17 @@ struct nd_pdsm_cmd_pkg {
>>  	__u8 payload[];		/* In/Out: Sub-cmd data buffer */
>>  } __packed;
>>  
>> +/* Calculate size used by the pdsm header fields minus 'struct nd_cmd_pkg' */
>> +#define ND_PDSM_ENVELOPE_HDR_SIZE \
>> +	(sizeof(struct nd_pdsm_cmd_pkg) - sizeof(struct nd_cmd_pkg))
>> +
[ ]
>
> This is kind of a weird name for this.
>
> Isn't this just the ND PDSM header size?  What is 'envelope' mean
> here?
Was referring to 'nd_cmd_pkg' envelop here. But yes removing 'ENVELOPE'
should make it more concise. Have already done this in v11 of this patch.

>
>>  /*
>>   * Methods to be embedded in ND_CMD_CALL request. These are sent to the kernel
>>   * via 'nd_pdsm_cmd_pkg.hdr.nd_command' member of the ioctl struct
>>   */
>>  enum papr_pdsm {
>>  	PAPR_PDSM_MIN = 0x0,
>> +	PAPR_PDSM_HEALTH,
>>  	PAPR_PDSM_MAX,
>>  };
>>  
>> @@ -95,4 +100,32 @@ static inline void *pdsm_cmd_to_payload(struct nd_pdsm_cmd_pkg *pcmd)
>>  		return (void *)(pcmd->payload);
>>  }
>>  
>> +/* Various nvdimm health indicators */
>> +#define PAPR_PDSM_DIMM_HEALTHY       0
>> +#define PAPR_PDSM_DIMM_UNHEALTHY     1
>> +#define PAPR_PDSM_DIMM_CRITICAL      2
>> +#define PAPR_PDSM_DIMM_FATAL         3
>> +
>> +/*
>> + * Struct exchanged between kernel & ndctl in for PAPR_PDSM_HEALTH
>> + * Various flags indicate the health status of the dimm.
>> + *
>> + * dimm_unarmed		: Dimm not armed. So contents wont persist.
>> + * dimm_bad_shutdown	: Previous shutdown did not persist contents.
>> + * dimm_bad_restore	: Contents from previous shutdown werent restored.
>> + * dimm_scrubbed	: Contents of the dimm have been scrubbed.
>> + * dimm_locked		: Contents of the dimm cant be modified until CEC reboot
>> + * dimm_encrypted	: Contents of dimm are encrypted.
>> + * dimm_health		: Dimm health indicator. One of PAPR_PDSM_DIMM_XXXX
>> + */
>> +struct nd_papr_pdsm_health {
>> +	__u8 dimm_unarmed;
>> +	__u8 dimm_bad_shutdown;
>> +	__u8 dimm_bad_restore;
>> +	__u8 dimm_scrubbed;
>> +	__u8 dimm_locked;
>> +	__u8 dimm_encrypted;
>> +	__u16 dimm_health;
>> +} __packed;
>> +
>>  #endif /* _UAPI_ASM_POWERPC_PAPR_PDSM_H_ */
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> index 05eb56ecab5e..984942be24c1 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -421,6 +421,72 @@ static int is_cmd_valid(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
>>  	return 0;
>>  }
>>  
>> +/* Fetch the DIMM health info and populate it in provided package. */
>> +static int papr_pdsm_health(struct papr_scm_priv *p,
>> +			    struct nd_pdsm_cmd_pkg *pkg)
>> +{
>> +	int rc;
>> +	struct nd_papr_pdsm_health health = { 0 };
>> +	u16 copysize = sizeof(struct nd_papr_pdsm_health);
>> +	u16 payload_size = pkg->hdr.nd_size_out - ND_PDSM_ENVELOPE_HDR_SIZE;
>> +
>> +	/* Ensure correct payload size that can hold struct nd_papr_pdsm_health */
>> +	if (payload_size != copysize) {
>> +		dev_dbg(&p->pdev->dev,
>> +			"Unexpected payload-size (%u). Expected (%u)",
>> +			pkg->hdr.nd_size_out, copysize);
>> +		rc = -ENOSPC;
>> +		goto out;
>> +	}
>> +
>> +	/* Ensure dimm health mutex is taken preventing concurrent access */
>> +	rc = mutex_lock_interruptible(&p->health_mutex);
>> +	if (rc)
>> +		goto out;
>> +
>> +	/* Always fetch upto date dimm health data ignoring cached values */
>> +	rc = __drc_pmem_query_health(p);
>> +	if (rc) {
>> +		mutex_unlock(&p->health_mutex);
>> +		goto out;
>> +	}
>> +
>> +	/* update health struct with various flags derived from health bitmap */
>> +	health = (struct nd_papr_pdsm_health) {
>> +		.dimm_unarmed = p->health_bitmap & PAPR_PMEM_UNARMED_MASK,
>> +		.dimm_bad_shutdown = p->health_bitmap & PAPR_PMEM_BAD_SHUTDOWN_MASK,
>> +		.dimm_bad_restore = p->health_bitmap & PAPR_PMEM_BAD_RESTORE_MASK,
>> +		.dimm_encrypted = p->health_bitmap & PAPR_PMEM_ENCRYPTED,
>> +		.dimm_locked = p->health_bitmap & PAPR_PMEM_SCRUBBED_AND_LOCKED,
>> +		.dimm_scrubbed = p->health_bitmap & PAPR_PMEM_SCRUBBED_AND_LOCKED,
>
> Are you sure these work?  These are not assignments to a bool so I don't think
> gcc will do what you want here.
Yeah, somehow this slipped by and didnt show up in my tests. I checked
the assembly dump and seems GCC was silently skipping initializing these
fields without making any noise. Have rectified this in v11 by changing
these designated initilizers to

           .dimm_locked = !!(p->health_bitmap & PAPR_PMEM_SCRUBBED_AND_LOCKED)

Thanks for catching this.

~ Vaibhav
>
> Ira
>
>> +		.dimm_health = PAPR_PDSM_DIMM_HEALTHY,
>> +	};
>> +
>> +	/* Update field dimm_health based on health_bitmap flags */
>> +	if (p->health_bitmap & PAPR_PMEM_HEALTH_FATAL)
>> +		health.dimm_health = PAPR_PDSM_DIMM_FATAL;
>> +	else if (p->health_bitmap & PAPR_PMEM_HEALTH_CRITICAL)
>> +		health.dimm_health = PAPR_PDSM_DIMM_CRITICAL;
>> +	else if (p->health_bitmap & PAPR_PMEM_HEALTH_UNHEALTHY)
>> +		health.dimm_health = PAPR_PDSM_DIMM_UNHEALTHY;
>> +
>> +	/* struct populated hence can release the mutex now */
>> +	mutex_unlock(&p->health_mutex);
>> +
>> +	dev_dbg(&p->pdev->dev, "Copying payload size=%u\n", copysize);
>> +
>> +	/* Copy the health struct to the payload */
>> +	memcpy(pdsm_cmd_to_payload(pkg), &health, copysize);
>> +
>> +	/* Update fw size including size of struct nd_pdsm_cmd_pkg fields */
>> +	pkg->hdr.nd_fw_size = copysize + ND_PDSM_ENVELOPE_HDR_SIZE;
>> +
>> +out:
>> +	dev_dbg(&p->pdev->dev, "completion code = %d\n", rc);
>> +
>> +	return rc;
>> +}
>> +
>>  /*
>>   * For a given pdsm request call an appropriate service function.
>>   * Note: Use 'nd_pdsm_cmd_pkg.cmd_status to report psdm servicing errors. Hence
>> @@ -435,6 +501,10 @@ static void papr_scm_service_pdsm(struct papr_scm_priv *p,
>>  
>>  	/* Call pdsm service function */
>>  	switch (pdsm) {
>> +	case PAPR_PDSM_HEALTH:
>> +		pkg->cmd_status = papr_pdsm_health(p, pkg);
>> +		break;
>> +
>>  	default:
>>  		dev_dbg(&p->pdev->dev, "PDSM[0x%x]: Unsupported PDSM request\n",
>>  			pdsm);
>> -- 
>> 2.26.2
>> 

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
