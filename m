Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC29081ACE
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Aug 2019 15:09:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A1201212E844B;
	Mon,  5 Aug 2019 06:12:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ED898212E842D
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 06:12:14 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x75D4Bjr021966
 for <linux-nvdimm@lists.01.org>; Mon, 5 Aug 2019 09:09:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u6j3x0xxq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Mon, 05 Aug 2019 09:09:43 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
 Mon, 5 Aug 2019 14:09:40 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 5 Aug 2019 14:09:38 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x75D9bqV41746436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Aug 2019 13:09:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6C4311C05C;
 Mon,  5 Aug 2019 13:09:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE34311C05E;
 Mon,  5 Aug 2019 13:09:34 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.109.195.181])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon,  5 Aug 2019 13:09:34 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation);
 Mon, 05 Aug 2019 18:39:33 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>,
 "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] ndctl,
 check: Ensure mmap of BTT sections work with 64K page-size
In-Reply-To: <b01607421be5f487662e973c30967a0bf8a8389d.camel@intel.com>
References: <20190704025143.22856-1-vaibhav@linux.ibm.com>
 <b01607421be5f487662e973c30967a0bf8a8389d.camel@intel.com>
Date: Mon, 05 Aug 2019 18:39:33 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19080513-0020-0000-0000-0000035B262E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080513-0021-0000-0000-000021AF40D1
Message-Id: <878ss721yq.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050146
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
Cc: "harish@linux.ibm.com" <harish@linux.ibm.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Thanks for reviewing this patch Vishal. I have prepped a v2 adressing
all your review comments with one exception below:

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Thu, 2019-07-04 at 08:21 +0530, Vaibhav Jain wrote:
>> Presently on PPC64 which uses a 64K page-size, ndtl-check command
>
> Drop 'Presently'. Maybe something like "On PPC64, ... ndctl-check-
> namespace would fail.."
>
> Also s/ndtl/ndctl/
>
>> fails on a BTT device with following error:
>
> on a BTT namespace.
>
>> 
>> $sudo ndctl check-namespace namespace0.0 -vv
>> namespace0.0: namespace_check: checking namespace0.0
>> namespace0.0: btt_discover_arenas: found 1 BTT arena
>> namespace0.0: btt_create_mappings: mmap arena[0].info [sz = 0x1000, off = 0x1000] failed: Invalid argument
>> error checking namespaces: Invalid argument
>> checked 0 namespaces
>
> Perhaps indent the above by two spaces so it is clearly visible as a
> copy-pasted session.
>
>> 
>> Error happens when btt_create_mappings() tries to mmap the sections of
>> the BTT device which are usually 4K offset aligned. However the mmap()
>> syscall expects the 'offset' argument to be in multiples of page-size,
>> hence it returns EINVAL causing the btt_create_mappings() to error
>> out.
>> 
>> As a fix for the issue this patch proposes addition of two new
>> functions to 'check.c' namely btt_mmap/btt_unmap that can be used to
>> map/unmap parts of BTT device to ndctl process address-space. The
>> functions tweaks the requested 'offset' argument to mmap() ensuring
>> that its page-size aligned and then fix-ups the returned pointer such
>> that it points to the requested offset within m-mapped region.
>
> 'mmaped region'
>
>> 
>> Reported-by: harish@linux.ibm.com
>
> Could you make this the canonical Name <email> format?
>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>>  ndctl/check.c | 71 ++++++++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 56 insertions(+), 15 deletions(-)
>> 
>> diff --git a/ndctl/check.c b/ndctl/check.c
>> index 8a7125053865..18d259048616 100644
>> --- a/ndctl/check.c
>> +++ b/ndctl/check.c
>> @@ -907,6 +907,47 @@ static int btt_discover_arenas(struct btt_chk *bttc)
>>  	return ret;
>>  }
>>  
>> +/* Mmap requested btt region so it works with non 4-K page sizes */
>
> Maybe something like "Wrap mmap(2) so that the underlying system call
> can use system page sizes for the mappings, but the checking code
> doesn't have to worry about that detail, and can map smaller-than-page-
> size sections"
>
>> +static void *btt_mmap(struct btt_chk *bttc, void *addr, size_t length,
>> +		      int prot, int flags, off_t offset)
>
> I see you tried to keep the argument list similar to mmap(2), but I
> suspect it can be made much cleaner if we only pass in just what's
> needed.
>
> Since we're passing in bttc, the bttc->opts->repair check to determine
> mmap_flags could be moved into this helper. The NULL and MAP_SHARED
> arguments (addr and prot) are always the same, so no need to pass those.
> With this, the callers look much cleaner:
>
> a->map_info = btt_mmap(bttc, a->map.info_len, a->infooff);
>
>> +{
>> +	off_t shift;
>
> In both of thse wrappers, and especially since we are printing 'shift ='
> in a debug message - 
>
> 'shift' sounds more like an arithmatic left/right shift operation, and
> it might be confusing to the user what it means. I'd suggest naming this
> something like 'page_offset', or 'page_start_pad', or something along
> those lines.
>
>> +
>> +	/* Calculate the shift back needed to make offset page aligned */
>
> "Calculate the offset from system page size boundary"
>
>> +	shift = offset - rounddown(offset, bttc->sys_page_size);
>> +
>> +	/* Update the offset and length with the shift calculated above */
>> +	offset -= shift;
>> +	length += shift;
>> +
>> +	addr = mmap(addr, length, prot, flags, bttc->fd, offset);
>> +
>> +	/* If needed fixup the return pointer to correct offset request */
>
> requested
>
>> +	if (addr != MAP_FAILED)
>> +		addr = (void *) ((uintptr_t)addr + shift);
>
> The (uintptr_t) cast should be ok to drop, for v66 we are removing the
> pointer arithmatic warning:
> https://patchwork.kernel.org/patch/11062697/
>
> In fact, since 'shift' is in bytes, isn't an unsigned int cast
> actually *wrong*?
Not sure if I understand your review comment correctly. With uintptr_t
cast and 'shift' in bytes, addr will be assigned 'addr + shift' instead
of 'addr + shift * sizeof (unsigned int)'

So I think the arithmetic I am doing here is correct.

>
>> +
>> +	dbg(bttc, "mmap: addr=%p length=0x%lx offset=0x%lx shift=0x%lx\n",
>> +	    addr, length, offset, shift);
>
> It would be nice to make this print more consistent with the err()
> prints in btt_create_mappings - so spaces sround the '=', and note you
> can use %#lx instead of 0x%lx
>
> Also the function name 'btt_map' will automatically get prefixed by
> dbg(), so no need for another 'mmap' at the start.
>
> 	dbg(bttc, "addr = %p, length = %#lx, offset = %#lx, page_offset = %#lx\n",
> 		addr, length, offset, page_offset);
>
>> +
>> +	return addr;
>> +}
>> +
>> +static void btt_unmap(struct btt_chk *bttc, void *ptr, size_t length)
>> +{
>> +	uintptr_t addr = ptr;
>> +	off_t shift;
>> +
>> +	/* Calculate the shift back needed to make offset page aligned */
>> +	shift = addr - rounddown(addr, bttc->sys_page_size);
>> +
>> +	addr -= shift;
>> +	length += shift;
>> +
>> +	munmap((void *)addr, length);
>> +	dbg(bttc, "unmap: addr=%p length=0x%lx shift=0x%lx\n",
>> +	    addr, length, shift);
>
> Similar comments about the print as above.
>
>> +}
>> +
>>  static int btt_create_mappings(struct btt_chk *bttc)
>>  {
>>  	struct arena_info *a;
>> @@ -921,8 +962,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
>>  	for (i = 0; i < bttc->num_arenas; i++) {
>>  		a = &bttc->arena[i];
>>  		a->map.info_len = BTT_INFO_SIZE;
>> -		a->map.info = mmap(NULL, a->map.info_len, mmap_flags,
>> -			MAP_SHARED, bttc->fd, a->infooff);
>> +		a->map.info = btt_mmap(bttc, NULL, a->map.info_len, mmap_flags,
>> +				       MAP_SHARED, a->infooff);
>>  		if (a->map.info == MAP_FAILED) {
>
> I wonder if it will also be cleaner to sequester away the MAP_FAILED
> detail of the mmap API into the wrapper. The wrapper can just return
> NULL for MAP_FAILED, and then this check just becomes if (!a->map.info)
>
>>  			err(bttc, "mmap arena[%d].info [sz = %#lx, off = %#lx] failed: %s\n",
>>  				i, a->map.info_len, a->infooff, strerror(errno));
>> @@ -930,8 +971,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
>>  		}
>>  
>>  		a->map.data_len = a->mapoff - a->dataoff;
>> -		a->map.data = mmap(NULL, a->map.data_len, mmap_flags,
>> -			MAP_SHARED, bttc->fd, a->dataoff);
>> +		a->map.data = btt_mmap(bttc, NULL, a->map.data_len, mmap_flags,
>> +				       MAP_SHARED, a->dataoff);
>>  		if (a->map.data == MAP_FAILED) {
>>  			err(bttc, "mmap arena[%d].data [sz = %#lx, off = %#lx] failed: %s\n",
>>  				i, a->map.data_len, a->dataoff, strerror(errno));
>> @@ -939,8 +980,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
>>  		}
>>  
>>  		a->map.map_len = a->logoff - a->mapoff;
>> -		a->map.map = mmap(NULL, a->map.map_len, mmap_flags,
>> -			MAP_SHARED, bttc->fd, a->mapoff);
>> +		a->map.map = btt_mmap(bttc, NULL, a->map.map_len, mmap_flags,
>> +				      MAP_SHARED, a->mapoff);
>>  		if (a->map.map == MAP_FAILED) {
>>  			err(bttc, "mmap arena[%d].map [sz = %#lx, off = %#lx] failed: %s\n",
>>  				i, a->map.map_len, a->mapoff, strerror(errno));
>> @@ -948,8 +989,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
>>  		}
>>  
>>  		a->map.log_len = a->info2off - a->logoff;
>> -		a->map.log = mmap(NULL, a->map.log_len, mmap_flags,
>> -			MAP_SHARED, bttc->fd, a->logoff);
>> +		a->map.log = btt_mmap(bttc, NULL, a->map.log_len, mmap_flags,
>> +				  MAP_SHARED, a->logoff);
>>  		if (a->map.log == MAP_FAILED) {
>>  			err(bttc, "mmap arena[%d].log [sz = %#lx, off = %#lx] failed: %s\n",
>>  				i, a->map.log_len, a->logoff, strerror(errno));
>> @@ -957,8 +998,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
>>  		}
>>  
>>  		a->map.info2_len = BTT_INFO_SIZE;
>> -		a->map.info2 = mmap(NULL, a->map.info2_len, mmap_flags,
>> -			MAP_SHARED, bttc->fd, a->info2off);
>> +		a->map.info2 = btt_mmap(bttc, NULL, a->map.info2_len,
>> +					mmap_flags, MAP_SHARED, a->info2off);
>>  		if (a->map.info2 == MAP_FAILED) {
>>  			err(bttc, "mmap arena[%d].info2 [sz = %#lx, off = %#lx] failed: %s\n",
>>  				i, a->map.info2_len, a->info2off, strerror(errno));
>> @@ -977,15 +1018,15 @@ static void btt_remove_mappings(struct btt_chk *bttc)
>>  	for (i = 0; i < bttc->num_arenas; i++) {
>>  		a = &bttc->arena[i];
>>  		if (a->map.info)
>> -			munmap(a->map.info, a->map.info_len);
>> +			btt_unmap(bttc, a->map.info, a->map.info_len);
>>  		if (a->map.data)
>> -			munmap(a->map.data, a->map.data_len);
>> +			btt_unmap(bttc, a->map.data, a->map.data_len);
>>  		if (a->map.map)
>> -			munmap(a->map.map, a->map.map_len);
>> +			btt_unmap(bttc, a->map.map, a->map.map_len);
>>  		if (a->map.log)
>> -			munmap(a->map.log, a->map.log_len);
>> +			btt_unmap(bttc, a->map.log, a->map.log_len);
>>  		if (a->map.info2)
>> -			munmap(a->map.info2, a->map.info2_len);
>> +			btt_unmap(bttc, a->map.info2, a->map.info2_len);
>>  	}
>>  }
>>  
>
>

Cheers,
-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
