Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1F139452
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jan 2020 16:08:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF7A010097E0E;
	Mon, 13 Jan 2020 07:12:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 168F910097E0D
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jan 2020 07:12:01 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DF1VTo033034;
	Mon, 13 Jan 2020 10:08:41 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2xfva18mkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2020 10:08:41 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00DF1tbD036021;
	Mon, 13 Jan 2020 10:08:40 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2xfva18mk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2020 10:08:40 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00DF4tV6017556;
	Mon, 13 Jan 2020 15:08:40 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by ppma05wdc.us.ibm.com with ESMTP id 2xf755b1p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2020 15:08:40 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00DF8dME27525416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2020 15:08:39 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81153AE05F;
	Mon, 13 Jan 2020 15:08:39 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FF55AE05C;
	Mon, 13 Jan 2020 15:08:38 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.93.127])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2020 15:08:37 +0000 (GMT)
X-Mailer: emacs 27.0.60 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
In-Reply-To: <CAPcyv4jKC=TBYh7pnF__iHNpcunifcRKhz4eQ3t86uCd4ZNNwg@mail.gmail.com>
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
 <x49muavm4gx.fsf@segfault.boston.devel.redhat.com>
 <253f7f57-d27f-91f1-4e99-ff69a0e88084@linux.ibm.com>
 <CAPcyv4jKC=TBYh7pnF__iHNpcunifcRKhz4eQ3t86uCd4ZNNwg@mail.gmail.com>
Date: Mon, 13 Jan 2020 20:38:33 +0530
Message-ID: <87lfqbl7gu.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_04:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130124
Message-ID-Hash: GGCYGATBHDJ43Z4Q2T5HAYCX7AYA3K2P
X-Message-ID-Hash: GGCYGATBHDJ43Z4Q2T5HAYCX7AYA3K2P
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GGCYGATBHDJ43Z4Q2T5HAYCX7AYA3K2P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Jan 10, 2020 at 8:33 PM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 1/11/20 2:08 AM, Jeff Moyer wrote:
>> > Hi, Aneesh,
>
>> "namespace0.2" not having a 2MB aligned size which cause namespace 0.1
>> start addr to be not aligned. Hence both the namespace are marked disabled.
>>
>
> 2 observations:
>
> - It's ok if the namespace start address is not subsection aligned as
> long as the mapped portion for data access is subsection aligned, at
> least on x86.
>
> - "sector" mode namespaces are not mapped by devm_memremap_pages() so
> there should be no restriction there. If powerpc can't map them that's
> a separate concern.

Does that mean the `supported_size_align` attribute should be a property
of pfn and dax seed device? Considering we don't want to apply this
restrictions for blk, raw namespace, and btt mode namespace should we
make the attribute a seed device property rather than a namespace
property?


>
> So, cross arch compatible namespaces is a goal, but not regressing
> existing namespaces takes precedence. I'd be happy if newly created
> namespaces tried to account for all the arch quirks, but if libnvdimm
> can enable a namespace it should try.

Ok. So that means we apply the alignment rules when creating new
namespaces irrespective of its type/mode. But when initializing via scan
label we only apply them for devdax and fsdax namespace?

Something like

static bool nvdimm_valid_namespace(struct device *dev,
		struct nd_namespace_common *ndns, resource_size_t size)
{
	struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
	unsigned long align_size = arch_namespace_align_size();
	struct resource *res;
	u32 remainder;

	/*
	 * Don't validate the start and size for blk namespace type
	 */
	if (is_namespace_blk(&ndns->dev))
		return true;

	/*
	 * For btt and raw namespace we use ioremap. Assume both can work
	 * with PAGE_SIZE alignment.
	 */
	if (is_nd_btt(dev) || is_namespace_io(dev))
		return true;

	div_u64_rem(size, align_size * nd_region->ndr_mappings, &remainder);
	if (remainder)
		return false;

	if (is_namespace_pmem(&ndns->dev)) {
		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(&ndns->dev);

		res = &nspm->nsio.res;
	} else
		/* cannot reach */
		return false;

	div_u64_rem(res->start, align_size * nd_region->ndr_mappings, &remainder);
	if (remainder)
		return false;

	return true;
}

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
