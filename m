Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1261EEA82
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jun 2020 20:49:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 74189100A22F5;
	Thu,  4 Jun 2020 11:44:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 689DA100A302C
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 11:44:36 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 054Ia90J026522;
	Thu, 4 Jun 2020 14:49:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31etw2q70a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 14:49:13 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 054IaAYK026549;
	Thu, 4 Jun 2020 14:49:13 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31etw2q6y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 14:49:13 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054ILi86022879;
	Thu, 4 Jun 2020 18:49:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma05fra.de.ibm.com with ESMTP id 31bf4849n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 18:49:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 054In8nZ65011852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2020 18:49:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F12AA4064;
	Thu,  4 Jun 2020 18:49:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71F9A405F;
	Thu,  4 Jun 2020 18:49:04 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.17.54])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu,  4 Jun 2020 18:49:04 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 05 Jun 2020 00:19:03 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v9 5/5] powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH
In-Reply-To: <20200603231814.GK1505637@iweiny-DESK2.sc.intel.com>
References: <20200602101438.73929-1-vaibhav@linux.ibm.com> <20200602101438.73929-6-vaibhav@linux.ibm.com> <20200602211901.GA1676657@iweiny-DESK2.sc.intel.com> <87pnaggee3.fsf@linux.ibm.com> <20200603231814.GK1505637@iweiny-DESK2.sc.intel.com>
Date: Fri, 05 Jun 2020 00:19:03 +0530
Message-ID: <87bllyhdk0.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_12:2020-06-04,2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040129
Message-ID-Hash: UDNN6S4HV3JKVINMUKJ22K52IF27A3XW
X-Message-ID-Hash: UDNN6S4HV3JKVINMUKJ22K52IF27A3XW
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UDNN6S4HV3JKVINMUKJ22K52IF27A3XW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ira,

Thanks again for looking into patch. My responses below:

Ira Weiny <ira.weiny@intel.com> writes:

> On Thu, Jun 04, 2020 at 12:34:04AM +0530, Vaibhav Jain wrote:
>> Hi Ira,
>> 
>> Thanks for reviewing this patch. My responses below:
>> 
>> Ira Weiny <ira.weiny@intel.com> writes:
>> 
>> > On Tue, Jun 02, 2020 at 03:44:38PM +0530, Vaibhav Jain wrote:
>> >> This patch implements support for PDSM request 'PAPR_PDSM_HEALTH'
>> >> that returns a newly introduced 'struct nd_papr_pdsm_health' instance
>> >> containing dimm health information back to user space in response to
>> >> ND_CMD_CALL. This functionality is implemented in newly introduced
>> >> papr_pdsm_health() that queries the nvdimm health information and
>> >> then copies this information to the package payload whose layout is
>> >> defined by 'struct nd_papr_pdsm_health'.
>> >> 
>> >> The patch also introduces a new member 'struct papr_scm_priv.health'
>> >> thats an instance of 'struct nd_papr_pdsm_health' to cache the health
>> >> information of a nvdimm. As a result functions drc_pmem_query_health()
>> >> and flags_show() are updated to populate and use this new struct
>> >> instead of a u64 integer that was earlier used.
>> >> 
>> >> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
>> >> Cc: Dan Williams <dan.j.williams@intel.com>
>> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> >> Cc: Ira Weiny <ira.weiny@intel.com>
>> >> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> >> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> >> ---
>> >> Changelog:
>> >> 
>> >> Resend:
>> >> * Added ack from Aneesh.
>> >> 
>> >> v8..v9:
>> >> * s/PAPR_SCM_PDSM_HEALTH/PAPR_PDSM_HEALTH/g  [ Dan , Aneesh ]
>> >> * s/PAPR_SCM_PSDM_DIMM_*/PAPR_PDSM_DIMM_*/g
>> >> * Renamed papr_scm_get_health() to papr_psdm_health()
>> >> * Updated patch description to replace papr-scm dimm with nvdimm.
>> >> 
>> >> v7..v8:
>> >> * None
>> >> 
>> >> Resend:
>> >> * None
>> >> 
>> >> v6..v7:
>> >> * Updated flags_show() to use seq_buf_printf(). [Mpe]
>> >> * Updated papr_scm_get_health() to use newly introduced
>> >>   __drc_pmem_query_health() bypassing the cache [Mpe].
>> >> 
>> >> v5..v6:
>> >> * Added attribute '__packed' to 'struct nd_papr_pdsm_health_v1' to
>> >>   gaurd against possibility of different compilers adding different
>> >>   paddings to the struct [ Dan Williams ]
>> >> 
>> >> * Updated 'struct nd_papr_pdsm_health_v1' to use __u8 instead of
>> >>   'bool' and also updated drc_pmem_query_health() to take this into
>> >>   account. [ Dan Williams ]
>> >> 
>> >> v4..v5:
>> >> * None
>> >> 
>> >> v3..v4:
>> >> * Call the DSM_PAPR_SCM_HEALTH service function from
>> >>   papr_scm_service_dsm() instead of papr_scm_ndctl(). [Aneesh]
>> >> 
>> >> v2..v3:
>> >> * Updated struct nd_papr_scm_dimm_health_stat_v1 to use '__xx' types
>> >>   as its exported to the userspace [Aneesh]
>> >> * Changed the constants DSM_PAPR_SCM_DIMM_XX indicating dimm health
>> >>   from enum to #defines [Aneesh]
>> >> 
>> >> v1..v2:
>> >> * New patch in the series
>> >> ---
>> >>  arch/powerpc/include/uapi/asm/papr_pdsm.h |  39 +++++++
>> >>  arch/powerpc/platforms/pseries/papr_scm.c | 125 +++++++++++++++++++---
>> >>  2 files changed, 147 insertions(+), 17 deletions(-)
>> >> 
>> >> diff --git a/arch/powerpc/include/uapi/asm/papr_pdsm.h b/arch/powerpc/include/uapi/asm/papr_pdsm.h
>> >> index 6407fefcc007..411725a91591 100644
>> >> --- a/arch/powerpc/include/uapi/asm/papr_pdsm.h
>> >> +++ b/arch/powerpc/include/uapi/asm/papr_pdsm.h
>> >> @@ -115,6 +115,7 @@ struct nd_pdsm_cmd_pkg {
>> >>   */
>> >>  enum papr_pdsm {
>> >>  	PAPR_PDSM_MIN = 0x0,
>> >> +	PAPR_PDSM_HEALTH,
>> >>  	PAPR_PDSM_MAX,
>> >>  };
>> >>  
>> >> @@ -133,4 +134,42 @@ static inline void *pdsm_cmd_to_payload(struct nd_pdsm_cmd_pkg *pcmd)
>> >>  		return (void *)(pcmd->payload);
>> >>  }
>> >>  
>> >> +/* Various nvdimm health indicators */
>> >> +#define PAPR_PDSM_DIMM_HEALTHY       0
>> >> +#define PAPR_PDSM_DIMM_UNHEALTHY     1
>> >> +#define PAPR_PDSM_DIMM_CRITICAL      2
>> >> +#define PAPR_PDSM_DIMM_FATAL         3
>> >> +
>> >> +/*
>> >> + * Struct exchanged between kernel & ndctl in for PAPR_PDSM_HEALTH
>> >> + * Various flags indicate the health status of the dimm.
>> >> + *
>> >> + * dimm_unarmed		: Dimm not armed. So contents wont persist.
>> >> + * dimm_bad_shutdown	: Previous shutdown did not persist contents.
>> >> + * dimm_bad_restore	: Contents from previous shutdown werent restored.
>> >> + * dimm_scrubbed	: Contents of the dimm have been scrubbed.
>> >> + * dimm_locked		: Contents of the dimm cant be modified until CEC reboot
>> >> + * dimm_encrypted	: Contents of dimm are encrypted.
>> >> + * dimm_health		: Dimm health indicator. One of PAPR_PDSM_DIMM_XXXX
>> >> + */
>> >> +struct nd_papr_pdsm_health_v1 {
>> >> +	__u8 dimm_unarmed;
>> >> +	__u8 dimm_bad_shutdown;
>> >> +	__u8 dimm_bad_restore;
>> >> +	__u8 dimm_scrubbed;
>> >> +	__u8 dimm_locked;
>> >> +	__u8 dimm_encrypted;
>> >> +	__u16 dimm_health;
>> >> +} __packed;
>> >> +
>> >> +/*
>> >> + * Typedef the current struct for dimm_health so that any application
>> >> + * or kernel recompiled after introducing a new version automatically
>> >> + * supports the new version.
>> >> + */
>> >> +#define nd_papr_pdsm_health nd_papr_pdsm_health_v1
>> >> +
>> >> +/* Current version number for the dimm health struct */
>> >
>> > This can't be the 'current' version.  You will need a list of versions you
>> > support.  Because if the user passes in an old version you need to be able to
>> > respond with that old version.  Also if you plan to support 'return X for a Y
>> > query' then the user will need both X and Y defined to interpret X.
>> Yes, and that change will be introduced with addition of version-2 of
>> nd_papr_pdsm_health. Earlier version of the patchset[1] had such a table
>> implemented. But to simplify the patchset, as we are only dealing with
>> version-1 of the structs right now, it was dropped.
>> 
>> [1] :
>> https://lore.kernel.org/linuxppc-dev/20200220095805.197229-9-vaibhav@linux.ibm.com/
>
> I'm not sure I follow that comment.
>
> I feel like there is some confusion about what firmware can return vs the UAPI
> structure.  You have already marshaled the data between the 2.  We can define
> whatever we want for the UAPI structures throwing away data the kernel does not
> understand from the firmware.
>
>> 
>> >
>> >> +#define ND_PAPR_PDSM_HEALTH_VERSION 1
>> >> +
>> >>  #endif /* _UAPI_ASM_POWERPC_PAPR_PDSM_H_ */
>> >> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> >> index 5e2237e7ec08..c0606c0c659c 100644
>> >> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> >> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> >> @@ -88,7 +88,7 @@ struct papr_scm_priv {
>> >>  	unsigned long lasthealth_jiffies;
>> >>  
>> >>  	/* Health information for the dimm */
>> >> -	u64 health_bitmap;
>> >> +	struct nd_papr_pdsm_health health;
>> >
>> > ok so we are throwing away all the #defs from patch 1?  Are they still valid?
>> >
>> > I'm confused that patch 3 added this and we are throwing it away
>> > here...
>> The #defines are still valid, only the usage moved to a __drc_pmem_query_health().
>> 
>> >
>> >>  };
>> >>  
>> >>  static int drc_pmem_bind(struct papr_scm_priv *p)
>> >> @@ -201,6 +201,7 @@ static int drc_pmem_query_n_bind(struct papr_scm_priv *p)
>> >>  static int __drc_pmem_query_health(struct papr_scm_priv *p)
>> >>  {
>> >>  	unsigned long ret[PLPAR_HCALL_BUFSIZE];
>> >> +	u64 health;
>> >>  	long rc;
>> >>  
>> >>  	/* issue the hcall */
>> >> @@ -208,18 +209,46 @@ static int __drc_pmem_query_health(struct papr_scm_priv *p)
>> >>  	if (rc != H_SUCCESS) {
>> >>  		dev_err(&p->pdev->dev,
>> >>  			 "Failed to query health information, Err:%ld\n", rc);
>> >> -		rc = -ENXIO;
>> >> -		goto out;
>> >> +		return -ENXIO;
>> >
>> > I missed this...  probably did not need the goto in the first patch?
>> Yes, will get rid of the goto from patch-1.
>
> Cool.
>
>> 
>> >
>> >>  	}
>> >>  
>> >>  	p->lasthealth_jiffies = jiffies;
>> >> -	p->health_bitmap = ret[0] & ret[1];
>> >> +	health = ret[0] & ret[1];
>> >>  
>> >>  	dev_dbg(&p->pdev->dev,
>> >>  		"Queried dimm health info. Bitmap:0x%016lx Mask:0x%016lx\n",
>> >>  		ret[0], ret[1]);
>> >> -out:
>> >> -	return rc;
>> >> +
>> >> +	memset(&p->health, 0, sizeof(p->health));
>> >> +
>> >> +	/* Check for various masks in bitmap and set the buffer */
>> >> +	if (health & PAPR_PMEM_UNARMED_MASK)
>> >
>> > Oh ok...  odd.  (don't add code then just take it away in a series)
>> > You could have lead with the user structure and put this code in patch
>> > 3.
>> The struct nd_papr_pdsm_health in only introduced this patch in header
>> 'papr_pdsm.h' as means of exchanging nvdimm health information with
>> userspace. Introducing this struct without introducing the necessary
>> scafolding in 'papr_pdsm.h' would have been very counter-intutive.
>
> I respectfully disagree.  You intended to use a copy of this structure in
> kernel to store the data.  Just do that.
Have addressed this in v10 that doesnt resort to removing the
functionality that was introduced in an earlier patch.

>
>> 
>> >
>> > Why does the user need u8 to represent a single bit?  Does this help protect
>> > against endian issues?
>> This was 'bool' earlier but since type 'bool' isnt suitable for ioctl abi
>> and I wanted to avoid bit fields here as not sure if their packing may
>> differ across compilers hence replaced with u8.
>> 
>
> ok works for me...
>
>> >
>> >> +		p->health.dimm_unarmed = 1;
>> >> +
>> >> +	if (health & PAPR_PMEM_BAD_SHUTDOWN_MASK)
>> >> +		p->health.dimm_bad_shutdown = 1;
>> >> +
>> >> +	if (health & PAPR_PMEM_BAD_RESTORE_MASK)
>> >> +		p->health.dimm_bad_restore = 1;
>> >> +
>> >> +	if (health & PAPR_PMEM_ENCRYPTED)
>> >> +		p->health.dimm_encrypted = 1;
>> >> +
>> >> +	if (health & PAPR_PMEM_SCRUBBED_AND_LOCKED) {
>> >> +		p->health.dimm_locked = 1;
>> >> +		p->health.dimm_scrubbed = 1;
>> >> +	}
>> >> +
>> >> +	if (health & PAPR_PMEM_HEALTH_UNHEALTHY)
>> >> +		p->health.dimm_health = PAPR_PDSM_DIMM_UNHEALTHY;
>> >> +
>> >> +	if (health & PAPR_PMEM_HEALTH_CRITICAL)
>> >> +		p->health.dimm_health = PAPR_PDSM_DIMM_CRITICAL;
>> >> +
>> >> +	if (health & PAPR_PMEM_HEALTH_FATAL)
>> >> +		p->health.dimm_health = PAPR_PDSM_DIMM_FATAL;
>> >> +
>> >> +	return 0;
>> >>  }
>> >>  
>> >>  /* Min interval in seconds for assuming stable dimm health */
>> >> @@ -403,6 +432,58 @@ static int is_cmd_valid(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
>> >>  	return 0;
>> >>  }
>> >>  
>> >> +/* Fetch the DIMM health info and populate it in provided package. */
>> >> +static int papr_pdsm_health(struct papr_scm_priv *p,
>> >> +			       struct nd_pdsm_cmd_pkg *pkg)
>> >> +{
>> >> +	int rc;
>> >> +	size_t copysize = sizeof(p->health);
>> >> +
>> >> +	/* Ensure dimm health mutex is taken preventing concurrent access */
>> >> +	rc = mutex_lock_interruptible(&p->health_mutex);
>> >> +	if (rc)
>> >> +		goto out;
>> >> +
>> >> +	/* Always fetch upto date dimm health data ignoring cached values */
>> >> +	rc = __drc_pmem_query_health(p);
>> >> +	if (rc)
>> >> +		goto out_unlock;
>> >> +	/*
>> >> +	 * If the requested payload version is greater than one we know
>> >> +	 * about, return the payload version we know about and let
>> >> +	 * caller/userspace handle.
>> >> +	 */
>> >> +	if (pkg->payload_version > ND_PAPR_PDSM_HEALTH_VERSION)
>> >> +		pkg->payload_version = ND_PAPR_PDSM_HEALTH_VERSION;
>> >
>> > I know this seems easy now but I do think you will run into trouble later.
>> 
>> I did addressed this in an earlier iteration of this patchset[1] and
>> dropped it in favour of simplicity.
>> 
>> [1] :
>> https://lore.kernel.org/linuxppc-dev/20200220095805.197229-9-vaibhav@linux.ibm.com/
>  
> I don't see how that addresses this?  See my other email.
>
> Ira
>
>> 
>> > Ira
>> >
>> >> +
>> >> +	if (pkg->hdr.nd_size_out < copysize) {
>> >> +		dev_dbg(&p->pdev->dev, "Truncated payload (%u). Expected (%lu)",
>> >> +			pkg->hdr.nd_size_out, copysize);
>> >> +		rc = -ENOSPC;
>> >> +		goto out_unlock;
>> >> +	}
>> >> +
>> >> +	dev_dbg(&p->pdev->dev, "Copying payload size=%lu version=0x%x\n",
>> >> +		copysize, pkg->payload_version);
>> >> +
>> >> +	/* Copy the health struct to the payload */
>> >> +	memcpy(pdsm_cmd_to_payload(pkg), &p->health, copysize);
>> >> +	pkg->hdr.nd_fw_size = copysize;
>> >> +
>> >> +out_unlock:
>> >> +	mutex_unlock(&p->health_mutex);
>> >> +
>> >> +out:
>> >> +	/*
>> >> +	 * Put the error in out package and return success from function
>> >> +	 * so that errors if any are propogated back to userspace.
>> >> +	 */
>> >> +	pkg->cmd_status = rc;
>> >> +	dev_dbg(&p->pdev->dev, "completion code = %d\n", rc);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >>  static int papr_scm_service_pdsm(struct papr_scm_priv *p,
>> >>  				struct nd_pdsm_cmd_pkg *call_pkg)
>> >>  {
>> >> @@ -417,6 +498,9 @@ static int papr_scm_service_pdsm(struct papr_scm_priv *p,
>> >>  
>> >>  	/* Depending on the DSM command call appropriate service routine */
>> >>  	switch (call_pkg->hdr.nd_command) {
>> >> +	case PAPR_PDSM_HEALTH:
>> >> +		return papr_pdsm_health(p, call_pkg);
>> >> +
>> >>  	default:
>> >>  		dev_dbg(&p->pdev->dev, "Unsupported PDSM request 0x%llx\n",
>> >>  			call_pkg->hdr.nd_command);
>> >> @@ -485,34 +569,41 @@ static ssize_t flags_show(struct device *dev,
>> >>  	struct nvdimm *dimm = to_nvdimm(dev);
>> >>  	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
>> >>  	struct seq_buf s;
>> >> -	u64 health;
>> >>  	int rc;
>> >>  
>> >>  	rc = drc_pmem_query_health(p);
>> >>  	if (rc)
>> >>  		return rc;
>> >>  
>> >> -	/* Copy health_bitmap locally, check masks & update out buffer */
>> >> -	health = READ_ONCE(p->health_bitmap);
>> >> -
>> >>  	seq_buf_init(&s, buf, PAGE_SIZE);
>> >> -	if (health & PAPR_PMEM_UNARMED_MASK)
>> >> +
>> >> +	/* Protect concurrent modifications to papr_scm_priv */
>> >> +	rc = mutex_lock_interruptible(&p->health_mutex);
>> >> +	if (rc)
>> >> +		return rc;
>> >> +
>> >> +	if (p->health.dimm_unarmed)
>> >>  		seq_buf_printf(&s, "not_armed ");
>> >>  
>> >> -	if (health & PAPR_PMEM_BAD_SHUTDOWN_MASK)
>> >> +	if (p->health.dimm_bad_shutdown)
>> >>  		seq_buf_printf(&s, "flush_fail ");
>> >>  
>> >> -	if (health & PAPR_PMEM_BAD_RESTORE_MASK)
>> >> +	if (p->health.dimm_bad_restore)
>> >>  		seq_buf_printf(&s, "restore_fail ");
>> >>  
>> >> -	if (health & PAPR_PMEM_ENCRYPTED)
>> >> +	if (p->health.dimm_encrypted)
>> >>  		seq_buf_printf(&s, "encrypted ");
>> >>  
>> >> -	if (health & PAPR_PMEM_SMART_EVENT_MASK)
>> >> +	if (p->health.dimm_health)
>> >>  		seq_buf_printf(&s, "smart_notify ");
>> >>  
>> >> -	if (health & PAPR_PMEM_SCRUBBED_AND_LOCKED)
>> >> -		seq_buf_printf(&s, "scrubbed locked ");
>> >> +	if (p->health.dimm_scrubbed)
>> >> +		seq_buf_printf(&s, "scrubbed ");
>> >> +
>> >> +	if (p->health.dimm_locked)
>> >> +		seq_buf_printf(&s, "locked ");
>> >> +
>> >> +	mutex_unlock(&p->health_mutex);
>> >>  
>> >>  	if (seq_buf_used(&s))
>> >>  		seq_buf_printf(&s, "\n");
>> >> -- 
>> >> 2.26.2
>> >> 
>> 
>> -- 
>> Cheers
>> ~ Vaibhav

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
