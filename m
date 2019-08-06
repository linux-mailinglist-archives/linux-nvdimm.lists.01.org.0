Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9864882AD5
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 07:19:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 452C521311BFF;
	Mon,  5 Aug 2019 22:22:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 153EA2130D7DA
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 22:22:23 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 22:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,352,1559545200"; d="scan'208";a="175787837"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2019 22:19:53 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 5 Aug 2019 22:19:53 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.86]) by
 FMSMSX113.amr.corp.intel.com ([169.254.13.252]) with mapi id 14.03.0439.000;
 Mon, 5 Aug 2019 22:19:52 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] ndctl, check: Ensure mmap of BTT sections work with
 64K page-sizes
Thread-Topic: [PATCH v2] ndctl, check: Ensure mmap of BTT sections work with
 64K page-sizes
Thread-Index: AQHVTBRyyDxXFdxvdka/43QihuaHAqbuClKA
Date: Tue, 6 Aug 2019 05:19:51 +0000
Message-ID: <26253c7e5fa424fcaa832ef7a2a50ea94d181acf.camel@intel.com>
References: <20190806050334.2267-1-vaibhav@linux.ibm.com>
In-Reply-To: <20190806050334.2267-1-vaibhav@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.252.135.102]
Content-ID: <292723714F801748B780ECB675D4FB91@intel.com>
MIME-Version: 1.0
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

On Tue, 2019-08-06 at 10:33 +0530, Vaibhav Jain wrote:
> On PPC64 which uses a 64K page-size, ndtl-check command fails on a BTT
> namespace with following error:
> 
> $ sudo ndctl check-namespace namespace0.0 -vv
>   namespace0.0: namespace_check: checking namespace0.0
>   namespace0.0: btt_discover_arenas: found 1 BTT arena
>   namespace0.0: btt_create_mappings: mmap arena[0].info [sz = 0x1000,
>   	off = 0x1000] failed: Invalid argument
>   error checking namespaces: Invalid argument
>   checked 0 namespaces
> 
> An error happens when btt_create_mappings() tries to mmap the sections
> of the BTT device which are usually 4K offset aligned. However the
> mmap() syscall expects the 'offset' argument to be in multiples of
> page-size, hence it returns EINVAL causing the btt_create_mappings()
> to error out.
> 
> As a fix for the issue this patch proposes addition of two new
> functions to 'check.c' namely btt_mmap/btt_unmap that can be used to
> map/unmap parts of BTT device to ndctl process address-space. The
> functions tweaks the requested 'offset' argument to mmap() ensuring
> that its page-size aligned and then fix-ups the returned pointer such
> that it points to the requested offset within mmapped region.
> 
> With these newly introduced functions the patch updates the call-sites
> in 'check.c' to use these functions instead of mmap/unmap syscalls.
> Also since btt_mmap returns NULL if mmap operation fails, the
> error check call-sites can be made against NULL instead of MAP_FAILED.
> 
> Reported-by: Harish Sriram <harish@linux.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v2:
> * Updated patch description to include canonical email address of bug
>   reporter. [Vishal]
> * Improved the comment describing function btt_mmap() in 'check.c'
>   [Vishal]
> * Simplified the argument list for btt_mmap() to just accept bttc,
>   length and offset. Other arguments for mmap() are derived from these
>   args. [Vishal]
> * Renamed 'shift' variable in btt_mmap()/unmap() to 'page_offset'
>   [Vishal]
> * Improved the dbg() messages logged inside
>   btt_mmap()/unmap(). [Vishal]
> * Return NULL from btt_mmap() in case of an error. [Vishal]
> * Changed the all sites to btt_mmap() to perform error check against
>   NULL return value instead of MAP_FAILED. [Vishal]

Hi Vaibhav,

Thanks for the turnaround on these - just one minor nit below, but other
than that this looks good to me.

> ---
>  ndctl/check.c | 93 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 67 insertions(+), 26 deletions(-)
> 
> diff --git a/ndctl/check.c b/ndctl/check.c
> index 8a7125053865..e72b498f1ce1 100644
> --- a/ndctl/check.c
> +++ b/ndctl/check.c
> @@ -907,59 +907,100 @@ static int btt_discover_arenas(struct btt_chk *bttc)
>  	return ret;
>  }
>  
> -static int btt_create_mappings(struct btt_chk *bttc)
> +/*
> + * Wrap call to mmap(2) to work with btt device offsets that are not aligned
> + * to system page boundary. It works by rounding down the requested offset
> + * to sys_page_size when calling mmap(2) and then returning a fixed-up pointer
> + * to the correct offset in the mmaped region.
> + */
> +static void *btt_mmap(struct btt_chk *bttc, size_t length, off_t offset)
>  {
> -	struct arena_info *a;
> -	int mmap_flags;
> -	int i;
> +	off_t page_offset;
> +	int prot_flags;
> +	uint8_t *addr;
>  
>  	if (!bttc->opts->repair)
> -		mmap_flags = PROT_READ;
> +		prot_flags = PROT_READ;
>  	else
> -		mmap_flags = PROT_READ|PROT_WRITE;
> +		prot_flags = PROT_READ|PROT_WRITE;
> +
> +	/* Calculate the page_offset from the system page boundary */
> +	page_offset = offset - rounddown(offset, bttc->sys_page_size);
> +
> +	/* Update the offset and length with the page_offset calculated above */
> +	offset -= page_offset;
> +	length += page_offset;
> +
> +	addr = mmap(NULL, length, prot_flags, MAP_SHARED, bttc->fd, offset);
> +
> +	/* If needed fixup the return pointer to correct offset requested */
> +	if (addr != MAP_FAILED)
> +		addr += page_offset;
> +
> +	dbg(bttc, "addr = %p length = %#lx offset = %#lx"
> +	    "page_offset = %#lx\n", (void *) addr, length, offset, page_offset);

The string portion of any print shouldn't ever be split across lines to
preserve greppability (the kernel CodingStyle document we follow
mentions that, and 'checkpatch.pl' should warn abnout it too. It is ok
in this case if the line ends up over 80 columns wide. Also maybe add
commas between the elements - so "addr = %p, length = %#lx, ..."

Same applies to the print in the unmap function below.

> +
> +	return addr == MAP_FAILED ? NULL : addr;
> +}
> +
> +static void btt_unmap(struct btt_chk *bttc, void *ptr, size_t length)
> +{
> +	off_t page_offset;
> +	uintptr_t addr = (uintptr_t) ptr;
> +
> +	/* Calculate the page_offset from system page boundary */
> +	page_offset = addr - rounddown(addr, bttc->sys_page_size);
> +
> +	addr -= page_offset;
> +	length += page_offset;
> +
> +	munmap((void *) addr, length);
> +	dbg(bttc, "addr = %p length = %#lx page_offset = %#lx\n",
> +	    (void *) addr, length, page_offset);
> +}
> +
> +static int btt_create_mappings(struct btt_chk *bttc)
> +{
> +	struct arena_info *a;
> +	int i;
>  
>  	for (i = 0; i < bttc->num_arenas; i++) {
>  		a = &bttc->arena[i];
>  		a->map.info_len = BTT_INFO_SIZE;
> -		a->map.info = mmap(NULL, a->map.info_len, mmap_flags,
> -			MAP_SHARED, bttc->fd, a->infooff);
> -		if (a->map.info == MAP_FAILED) {
> +		a->map.info = btt_mmap(bttc, a->map.info_len, a->infooff);
> +		if (!a->map.info) {
>  			err(bttc, "mmap arena[%d].info [sz = %#lx, off = %#lx] failed: %s\n",
>  				i, a->map.info_len, a->infooff, strerror(errno));
>  			return -errno;
>  		}
>  
>  		a->map.data_len = a->mapoff - a->dataoff;
> -		a->map.data = mmap(NULL, a->map.data_len, mmap_flags,
> -			MAP_SHARED, bttc->fd, a->dataoff);
> -		if (a->map.data == MAP_FAILED) {
> +		a->map.data = btt_mmap(bttc, a->map.data_len, a->dataoff);
> +		if (!a->map.data) {
>  			err(bttc, "mmap arena[%d].data [sz = %#lx, off = %#lx] failed: %s\n",
>  				i, a->map.data_len, a->dataoff, strerror(errno));
>  			return -errno;
>  		}
>  
>  		a->map.map_len = a->logoff - a->mapoff;
> -		a->map.map = mmap(NULL, a->map.map_len, mmap_flags,
> -			MAP_SHARED, bttc->fd, a->mapoff);
> -		if (a->map.map == MAP_FAILED) {
> +		a->map.map = btt_mmap(bttc, a->map.map_len, a->mapoff);
> +		if (!a->map.map) {
>  			err(bttc, "mmap arena[%d].map [sz = %#lx, off = %#lx] failed: %s\n",
>  				i, a->map.map_len, a->mapoff, strerror(errno));
>  			return -errno;
>  		}
>  
>  		a->map.log_len = a->info2off - a->logoff;
> -		a->map.log = mmap(NULL, a->map.log_len, mmap_flags,
> -			MAP_SHARED, bttc->fd, a->logoff);
> -		if (a->map.log == MAP_FAILED) {
> +		a->map.log = btt_mmap(bttc, a->map.log_len, a->logoff);
> +		if (!a->map.log) {
>  			err(bttc, "mmap arena[%d].log [sz = %#lx, off = %#lx] failed: %s\n",
>  				i, a->map.log_len, a->logoff, strerror(errno));
>  			return -errno;
>  		}
>  
>  		a->map.info2_len = BTT_INFO_SIZE;
> -		a->map.info2 = mmap(NULL, a->map.info2_len, mmap_flags,
> -			MAP_SHARED, bttc->fd, a->info2off);
> -		if (a->map.info2 == MAP_FAILED) {
> +		a->map.info2 = btt_mmap(bttc, a->map.info2_len, a->info2off);
> +		if (!a->map.info2) {
>  			err(bttc, "mmap arena[%d].info2 [sz = %#lx, off = %#lx] failed: %s\n",
>  				i, a->map.info2_len, a->info2off, strerror(errno));
>  			return -errno;
> @@ -977,15 +1018,15 @@ static void btt_remove_mappings(struct btt_chk *bttc)
>  	for (i = 0; i < bttc->num_arenas; i++) {
>  		a = &bttc->arena[i];
>  		if (a->map.info)
> -			munmap(a->map.info, a->map.info_len);
> +			btt_unmap(bttc, a->map.info, a->map.info_len);
>  		if (a->map.data)
> -			munmap(a->map.data, a->map.data_len);
> +			btt_unmap(bttc, a->map.data, a->map.data_len);
>  		if (a->map.map)
> -			munmap(a->map.map, a->map.map_len);
> +			btt_unmap(bttc, a->map.map, a->map.map_len);
>  		if (a->map.log)
> -			munmap(a->map.log, a->map.log_len);
> +			btt_unmap(bttc, a->map.log, a->map.log_len);
>  		if (a->map.info2)
> -			munmap(a->map.info2, a->map.info2_len);
> +			btt_unmap(bttc, a->map.info2, a->map.info2_len);
>  	}
>  }
>  
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
