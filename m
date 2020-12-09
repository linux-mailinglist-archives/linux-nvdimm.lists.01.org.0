Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BEB2D3986
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 05:17:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A60FB100EC1DE;
	Tue,  8 Dec 2020 20:17:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E9113100EF275
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 20:17:42 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B944F8X192137;
	Tue, 8 Dec 2020 23:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Vw7yOwYIDmlZUm0TaZ9ypdpSY/2h5srsFNIEmRkhsJM=;
 b=qtDN8JxGAhZbB9+XHo+IXKFlEnwB7cR9pJVISeaWcva5HNigkYN5WjSvA9ZoEWdbG7f1
 c3ofSvnyl13gICpR+JoKKKg8m+JKdDUkVXOhRw/GpBZnJGALE7gA9+HbiXEwdwvCI+Ne
 ZofUSpiwWuAbzCs2G2Vf0bslllBTdVNA+QvQ3u/Sa6xSBm2RJ7OoFbbZF38bAykl7Y7d
 S1K5bQs7bJGZxzXyCip/OJiCUizTaFiBo4yrCWCDLGtZb6JeVIND7INL2IciuMajtL0F
 lQBnzYA/2E6qrZeBbz0Rfq7a9NiDFILEtY892vRJ++w7537RCkSvqwbdToQH1UgMgf5i 2w==
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 35ageht39b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Dec 2020 23:17:40 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B94CBij018156;
	Wed, 9 Dec 2020 04:17:38 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma04fra.de.ibm.com with ESMTP id 3581u8253f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Dec 2020 04:17:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B94HZqI31129918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Dec 2020 04:17:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F074203F;
	Wed,  9 Dec 2020 04:17:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDD8842047;
	Wed,  9 Dec 2020 04:17:32 +0000 (GMT)
Received: from [9.199.38.90] (unknown [9.199.38.90])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  9 Dec 2020 04:17:32 +0000 (GMT)
Subject: Re: [PATCH RFC v3] testing/nvdimm: Add test module for non-nfit
 platforms
To: Dan Williams <dan.j.williams@intel.com>,
        Santosh Sivaraj <santosh@fossix.org>
References: <20201006010013.848302-1-santosh@fossix.org>
 <CAPcyv4jEpw2Yvj1eVNaW6z7D=pf31w1cQXuF9ymqxckhxANeCQ@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <50842a9b-2ff8-2623-fe00-7c91e9405131@linux.ibm.com>
Date: Wed, 9 Dec 2020 09:47:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jEpw2Yvj1eVNaW6z7D=pf31w1cQXuF9ymqxckhxANeCQ@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_03:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090027
Message-ID-Hash: DWA6Q4ZRVD62WWCC3X45R7KPOXDY4A6L
X-Message-ID-Hash: DWA6Q4ZRVD62WWCC3X45R7KPOXDY4A6L
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DWA6Q4ZRVD62WWCC3X45R7KPOXDY4A6L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/8/20 3:30 AM, Dan Williams wrote:
> On Mon, Oct 5, 2020 at 6:01 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>

...

>> +static int ndtest_blk_do_io(struct nd_blk_region *ndbr, resource_size_t dpa,
>> +               void *iobuf, u64 len, int rw)
>> +{
>> +       struct ndtest_dimm *dimm = ndbr->blk_provider_data;
>> +       struct ndtest_blk_mmio *mmio = dimm->mmio;
>> +       struct nd_region *nd_region = &ndbr->nd_region;
>> +       unsigned int lane;
>> +
>> +       lane = nd_region_acquire_lane(nd_region);
>> +
>> +       if (rw)
>> +               memcpy(mmio->base + dpa, iobuf, len);
>> +       else {
>> +               memcpy(iobuf, mmio->base + dpa, len);
>> +               arch_invalidate_pmem(mmio->base + dpa, len);
>> +       }
>> +
>> +       nd_region_release_lane(nd_region, lane);
>> +
>> +       return 0;
>> +}
>> +
>> +static int ndtest_blk_region_enable(struct nvdimm_bus *nvdimm_bus,
>> +                                   struct device *dev)
>> +{
>> +       struct nd_blk_region *ndbr = to_nd_blk_region(dev);
>> +       struct nvdimm *nvdimm;
>> +       struct ndtest_dimm *p;
>> +       struct ndtest_blk_mmio *mmio;
>> +
>> +       nvdimm = nd_blk_region_to_dimm(ndbr);
>> +       p = nvdimm_provider_data(nvdimm);
>> +
>> +       nd_blk_region_set_provider_data(ndbr, p);
>> +       p->region = to_nd_region(dev);
>> +
>> +       mmio = devm_kzalloc(dev, sizeof(struct ndtest_blk_mmio), GFP_KERNEL);
>> +       if (!mmio)
>> +               return -ENOMEM;
>> +
>> +       mmio->base = devm_nvdimm_memremap(dev, p->address, 12,
>> +                                        nd_blk_memremap_flags(ndbr));
>> +       if (!mmio->base) {
>> +               dev_err(dev, "%s failed to map blk dimm\n", nvdimm_name(nvdimm));
>> +               return -ENOMEM;
>> +       }
>> +
>> +       p->mmio = mmio;
>> +
>> +       return 0;
>> +}
> 
> Are there any ppc nvdimm that will use BLK mode? As far as I know
> BLK-mode is only an abandoned mechanism in the ACPI specification, not
> anything that has made it into a shipping implementation. I'd prefer
> to not extend it if it's not necessary.
> 
That is correct. There is no BLK mode/type usage in ppc64. But IIUC, we 
also had difficulty in isolating the BLK test to ACPI systems. The test 
code had dependencies and splitting that out was making it complex.


-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
