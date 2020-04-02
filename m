Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E3419BEAF
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 11:31:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0037A10FC6786;
	Thu,  2 Apr 2020 02:31:52 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vajain21@vajain21.in.ibm.com.in.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3C44910FC6782
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 02:31:46 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032949Yc109450
	for <linux-nvdimm@lists.01.org>; Thu, 2 Apr 2020 05:30:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3020wfpr3k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 02 Apr 2020 05:30:56 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vajain21@vajain21.in.ibm.com.in.ibm.com>;
	Thu, 2 Apr 2020 10:30:46 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 2 Apr 2020 10:30:42 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0329UmsY54788168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2020 09:30:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF063A4054;
	Thu,  2 Apr 2020 09:30:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87A07A405F;
	Thu,  2 Apr 2020 09:30:45 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.46.171])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu,  2 Apr 2020 09:30:45 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 02 Apr 2020 15:00:44 +0530
From: Vaibhav Jain <vajain21@vajain21.in.ibm.com.in.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/papr_scm: Fetch nvdimm health information from PHYP
In-Reply-To: <CAPcyv4h5Nu4u-SSSOKtHr14ERGUw97EfH5eZR77ThcnqMqxJLg@mail.gmail.com>
References: <20200331143229.306718-1-vaibhav@linux.ibm.com> <20200331143229.306718-2-vaibhav@linux.ibm.com> <CAPcyv4h5Nu4u-SSSOKtHr14ERGUw97EfH5eZR77ThcnqMqxJLg@mail.gmail.com>
Date: Thu, 02 Apr 2020 15:00:44 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20040209-0012-0000-0000-0000039CCB63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040209-0013-0000-0000-000021D9DE5A
Message-Id: <87sghmfd4r.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_01:2020-03-31,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020078
Message-ID-Hash: EQLRUL4TYPN3JWERACZJNA3CUK3J3TC7
X-Message-ID-Hash: EQLRUL4TYPN3JWERACZJNA3CUK3J3TC7
X-MailFrom: vajain21@vajain21.in.ibm.com.in.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <ellerman@au1.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EQLRUL4TYPN3JWERACZJNA3CUK3J3TC7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

Thanks for reviewing this patchset,

Dan Williams <dan.j.williams@intel.com> writes:

> On Tue, Mar 31, 2020 at 7:33 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
>> Implement support for fetching nvdimm health information via
>> H_SCM_HEALTH hcall as documented in Ref[1]. The hcall returns a pair
>> of 64-bit big-endian integers which are then stored in 'struct
>> papr_scm_priv' and subsequently partially exposed to user-space via
>> newly introduced dimm specific attribute 'papr_flags'. Also a new asm
>> header named 'papr-scm.h' is added that describes the interface
>> between PHYP and guest kernel.
>>
>> Following flags are reported via 'papr_flags' sysfs attribute contents
>> of which are space separated string flags indicating various nvdimm
>> states:
>>
>>  * "not_armed"  : Indicating that nvdimm contents wont survive a power
>>                    cycle.
>
> s/wont/will not/
Will fix this in next version of this patchset.

>
>>  * "save_fail"  : Indicating that nvdimm contents couldn't be flushed
>>                    during last shutdown event.
>
> In the nfit definition this description is "flush_fail". The
> "save_fail" flag was specific to hybrid devices that don't have
> persistent media and instead scuttle away data from DRAM to flash on
> power-failure.
>
Agree, will change the flag string to "flush_fail" to better match nfit.


>>  * "restore_fail": Indicating that nvdimm contents couldn't be restored
>>                    during dimm initialization.
>>  * "encrypted"  : Dimm contents are encrypted.
>
> This does not seem like a health flag to me, have you considered the
> libnvdimm security interface for this indicator?
Right now PAPR scm spec doesnt allow in-band (guest kernel) control of nvdimm
encryption/scrubbing. It only provides bit flags indicating encrypted
status or scrubbed/locked status for a nvdimm. Hence right now just
exposing them as dimm flags. Once the inband-support for encrypting
nvdimms from guest kernels is in place we will implement nvdimm security
ops for papr_scm.

>>  * "smart_notify": There is health event for the nvdimm.
>
> Are you also going to signal the sysfs attribute when this event
> happens?
In future yes but at present no, as there are no notifications from
PowerVM Hypervisor to the kernel that indicate a change in health status of
a nvdimm. Hence we have to rely on userspace polling machenism. A patch to introduce
that machenism in ndctl was proposed with the patch "monitor: Add epoll
timeout for forcing a full dimm health check"
https://lore.kernel.org/linux-nvdimm/20200221175459.255556-1-vaibhav@linux.ibm.com

>
>>  * "scrubbed"   : Indicating that contents of the nvdimm have been
>>                    scrubbed.
>
> This one seems odd to me what does it mean if it is not set? What does
> it mean if a new scrub has been launched. Basically, is there value in
> exposing this state?
As with 'encrypted' flag scrubbing is right now not supported inband by
the guest kernel running on top of PowerVM Hypervisor. Its just a status
bit set by the hypervisor to indicate that a scrubbing operation was
completed.  Hence right now just exposing them as dimm flags.

>
>>  * "locked"     : Indicating that nvdimm contents cant be modified
>>                    until next power cycle.
>
> There is the generic NDD_LOCKED flag, can you use that? ...and in
> general I wonder if we should try to unify all the common papr_scm and
> nfit health flags in a generic location. It will already be the case
> the ndctl needs to look somewhere papr specific for this data maybe it
> all should have been generic from the beginning.
This flag is different from NDD_LOCKED flag as it indicates that
hot(un)plug of new nvdimm regions to the guest wont be allowed until
PowerVM hypervisor reboots. The flag description I have put looks misleading
in that regard and I will get it fixed in next version.

Unification of common nvdimm flags between nfit/papr_scm would be very
good idea but would also need some way to update nvdimm flags after
nvdimm_create()

>
> In any event, can you also add this content to a new
> Documentation/ABI/testing/sysfs-bus-papr? See sysfs-bus-nfit for
> comparison.
Agreed, will document these flags in sysfs ABI document in next
iteration of this patchset.

>
>>
>> [1]: commit 58b278f568f0 ("powerpc: Provide initial documentation for
>> PAPR hcalls")
>>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>>
>> v4..v5 : None
>>
>> v3..v4 : None
>>
>> v2..v3 : Removed PAPR_SCM_DIMM_HEALTH_NON_CRITICAL as a condition for
>>          NVDIMM unarmed [Aneesh]
>>
>> v1..v2 : New patch in the series.
>> ---
>>  arch/powerpc/include/asm/papr_scm.h       |  48 ++++++++++
>>  arch/powerpc/platforms/pseries/papr_scm.c | 105 +++++++++++++++++++++-
>>  2 files changed, 151 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/powerpc/include/asm/papr_scm.h
>>
>> diff --git a/arch/powerpc/include/asm/papr_scm.h b/arch/powerpc/include/asm/papr_scm.h
>> new file mode 100644
>> index 000000000000..868d3360f56a
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/papr_scm.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Structures and defines needed to manage nvdimms for spapr guests.
>> + */
>> +#ifndef _ASM_POWERPC_PAPR_SCM_H_
>> +#define _ASM_POWERPC_PAPR_SCM_H_
>> +
>> +#include <linux/types.h>
>> +#include <asm/bitsperlong.h>
>> +
>> +/* DIMM health bitmap bitmap indicators */
>> +/* SCM device is unable to persist memory contents */
>> +#define PAPR_SCM_DIMM_UNARMED                  PPC_BIT(0)
>> +/* SCM device failed to persist memory contents */
>> +#define PAPR_SCM_DIMM_SHUTDOWN_DIRTY           PPC_BIT(1)
>> +/* SCM device contents are persisted from previous IPL */
>> +#define PAPR_SCM_DIMM_SHUTDOWN_CLEAN           PPC_BIT(2)
>> +/* SCM device contents are not persisted from previous IPL */
>> +#define PAPR_SCM_DIMM_EMPTY                    PPC_BIT(3)
>> +/* SCM device memory life remaining is critically low */
>> +#define PAPR_SCM_DIMM_HEALTH_CRITICAL          PPC_BIT(4)
>> +/* SCM device will be garded off next IPL due to failure */
>> +#define PAPR_SCM_DIMM_HEALTH_FATAL             PPC_BIT(5)
>> +/* SCM contents cannot persist due to current platform health status */
>> +#define PAPR_SCM_DIMM_HEALTH_UNHEALTHY         PPC_BIT(6)
>> +/* SCM device is unable to persist memory contents in certain conditions */
>> +#define PAPR_SCM_DIMM_HEALTH_NON_CRITICAL      PPC_BIT(7)
>> +/* SCM device is encrypted */
>> +#define PAPR_SCM_DIMM_ENCRYPTED                        PPC_BIT(8)
>> +/* SCM device has been scrubbed and locked */
>> +#define PAPR_SCM_DIMM_SCRUBBED_AND_LOCKED      PPC_BIT(9)
>> +
>> +/* Bits status indicators for health bitmap indicating unarmed dimm */
>> +#define PAPR_SCM_DIMM_UNARMED_MASK (PAPR_SCM_DIMM_UNARMED |    \
>> +                                       PAPR_SCM_DIMM_HEALTH_UNHEALTHY)
>> +
>> +/* Bits status indicators for health bitmap indicating unflushed dimm */
>> +#define PAPR_SCM_DIMM_BAD_SHUTDOWN_MASK (PAPR_SCM_DIMM_SHUTDOWN_DIRTY)
>> +
>> +/* Bits status indicators for health bitmap indicating unrestored dimm */
>> +#define PAPR_SCM_DIMM_BAD_RESTORE_MASK  (PAPR_SCM_DIMM_EMPTY)
>> +
>> +/* Bit status indicators for smart event notification */
>> +#define PAPR_SCM_DIMM_SMART_EVENT_MASK (PAPR_SCM_DIMM_HEALTH_CRITICAL | \
>> +                                          PAPR_SCM_DIMM_HEALTH_FATAL | \
>> +                                          PAPR_SCM_DIMM_HEALTH_UNHEALTHY)
>> +
>> +#endif
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> index 0b4467e378e5..aaf2e4ab1f75 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/delay.h>
>>
>>  #include <asm/plpar_wrappers.h>
>> +#include <asm/papr_scm.h>
>>
>>  #define BIND_ANY_ADDR (~0ul)
>>
>> @@ -39,6 +40,13 @@ struct papr_scm_priv {
>>         struct resource res;
>>         struct nd_region *region;
>>         struct nd_interleave_set nd_set;
>> +
>> +       /* Protect dimm data from concurrent access */
>> +       struct mutex dimm_mutex;
>> +
>> +       /* Health information for the dimm */
>> +       __be64 health_bitmap;
>> +       __be64 health_bitmap_valid;
>>  };
>>
>>  static int drc_pmem_bind(struct papr_scm_priv *p)
>> @@ -144,6 +152,35 @@ static int drc_pmem_query_n_bind(struct papr_scm_priv *p)
>>         return drc_pmem_bind(p);
>>  }
>>
>> +static int drc_pmem_query_health(struct papr_scm_priv *p)
>> +{
>> +       unsigned long ret[PLPAR_HCALL_BUFSIZE];
>> +       int64_t rc;
>> +
>> +       rc = plpar_hcall(H_SCM_HEALTH, ret, p->drc_index);
>> +       if (rc != H_SUCCESS) {
>> +               dev_err(&p->pdev->dev,
>> +                        "Failed to query health information, Err:%lld\n", rc);
>> +               return -ENXIO;
>> +       }
>> +
>> +       /* Protect modifications to papr_scm_priv with the mutex */
>> +       rc = mutex_lock_interruptible(&p->dimm_mutex);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /* Store the retrieved health information in dimm platform data */
>> +       p->health_bitmap = ret[0];
>> +       p->health_bitmap_valid = ret[1];
>> +
>> +       dev_dbg(&p->pdev->dev,
>> +               "Queried dimm health info. Bitmap:0x%016llx Mask:0x%016llx\n",
>> +               be64_to_cpu(p->health_bitmap),
>> +               be64_to_cpu(p->health_bitmap_valid));
>> +
>> +       mutex_unlock(&p->dimm_mutex);
>> +       return 0;
>> +}
>>
>>  static int papr_scm_meta_get(struct papr_scm_priv *p,
>>                              struct nd_cmd_get_config_data_hdr *hdr)
>> @@ -304,6 +341,67 @@ static inline int papr_scm_node(int node)
>>         return min_node;
>>  }
>>
>> +static ssize_t papr_flags_show(struct device *dev,
>> +                               struct device_attribute *attr, char *buf)
>> +{
>> +       struct nvdimm *dimm = to_nvdimm(dev);
>> +       struct papr_scm_priv *p = nvdimm_provider_data(dimm);
>> +       __be64 health;
>> +       int rc;
>> +
>> +       rc = drc_pmem_query_health(p);
>> +       if (rc)
>> +               return rc;
>
> This attribute is user readable which means userspace can trigger and
> ongoing stream of device requests. Is that desired? The nfit driver
> caches this flag data, and limits attributes with device side-effects
> to root-only. The expectation is that ndctl submits commands to
> retrieve the up to date state especially because that payload has
> other interesting data like temperature that can't be cached.
Agree that this data can cached like nfit does. But wanted to keep this
patch simple and the structure that holds the health data will change in
patch-4 hence took a call to not include any caching machenism for now.

>
>> +
>> +       /* Protect against modifications to papr_scm_priv with the mutex */
>
> What papr_scm_priv modifications are you worried about because none of
> the below looks like it needs to be locked, and papr_scm_priv had
> better be stable otherwise the above usages would have crashed.
>
>> +       rc = mutex_lock_interruptible(&p->dimm_mutex);
>> +       if (rc)
>> +               return rc;
>> +
>> +       health = p->health_bitmap & p->health_bitmap_valid;
>> +
>> +       /* Check for various masks in bitmap and set the buffer */
>> +       if (health & PAPR_SCM_DIMM_UNARMED_MASK)
>> +               rc += sprintf(buf, "not_armed ");
>> +
>> +       if (health & PAPR_SCM_DIMM_BAD_SHUTDOWN_MASK)
>> +               rc += sprintf(buf + rc, "save_fail ");
>> +
>> +       if (health & PAPR_SCM_DIMM_BAD_RESTORE_MASK)
>> +               rc += sprintf(buf + rc, "restore_fail ");
>> +
>> +       if (health & PAPR_SCM_DIMM_ENCRYPTED)
>> +               rc += sprintf(buf + rc, "encrypted ");
>> +
>> +       if (health & PAPR_SCM_DIMM_SMART_EVENT_MASK)
>> +               rc += sprintf(buf + rc, "smart_notify ");
>> +
>> +       if (health & PAPR_SCM_DIMM_SCRUBBED_AND_LOCKED)
>> +               rc += sprintf(buf + rc, "scrubbed locked ");
>
> See above about whether we event need this here...
>
>> +
>> +       if (rc > 0)
>> +               rc += sprintf(buf + rc, "\n");
>> +
>> +       mutex_unlock(&p->dimm_mutex);
>> +       return rc;
>> +}
>> +DEVICE_ATTR_RO(papr_flags);
>
> Rather than name this attribute "papr_flags", I'd prefer "papr/flags".
> I.e. create a "papr" sub-directory...
>
Agree will include this change in the next iteration of this patchset.

>> +
>> +/* papr_scm specific dimm attributes */
>> +static struct attribute *papr_scm_nd_attributes[] = {
>> +       &dev_attr_papr_flags.attr,
>> +       NULL,
>> +};
>> +
>> +static struct attribute_group papr_scm_nd_attribute_group = {
>
> ...here:
>
>        .name = "papr",
>
>> +       .attrs = papr_scm_nd_attributes,
>> +};
>> +
>
> With the continued discussions this is going to need I hope you
> understand that I consider this v5.8 material.
>
Agreed

>> +static const struct attribute_group *papr_scm_dimm_attr_groups[] = {
>> +       &papr_scm_nd_attribute_group,
>> +       NULL,
>> +};
>> +
>>  static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>  {
>>         struct device *dev = &p->pdev->dev;
>> @@ -330,8 +428,8 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>         dimm_flags = 0;
>>         set_bit(NDD_ALIASING, &dimm_flags);
>>
>> -       p->nvdimm = nvdimm_create(p->bus, p, NULL, dimm_flags,
>> -                                 PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
>> +       p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_attr_groups,
>> +                                 dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
>>         if (!p->nvdimm) {
>>                 dev_err(dev, "Error creating DIMM object for %pOF\n", p->dn);
>>                 goto err;
>> @@ -415,6 +513,9 @@ static int papr_scm_probe(struct platform_device *pdev)
>>         if (!p)
>>                 return -ENOMEM;
>>
>> +       /* Initialize the dimm mutex */
>> +       mutex_init(&p->dimm_mutex);
>> +
>>         /* optional DT properties */
>>         of_property_read_u32(dn, "ibm,metadata-size", &metadata_size);
>>
>> --
>> 2.25.1
>>

-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
