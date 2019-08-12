Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2138A996
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 23:46:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D50D121314750;
	Mon, 12 Aug 2019 14:49:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 541C32130A511
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 14:49:05 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3BD13172D9A;
 Mon, 12 Aug 2019 21:46:46 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B7E92A17A;
 Mon, 12 Aug 2019 21:46:46 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v3] ndctl,
 check: Ensure mmap of BTT sections work with 64K page-sizes
References: <20190806105012.15170-1-vaibhav@linux.ibm.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 12 Aug 2019 17:46:45 -0400
In-Reply-To: <20190806105012.15170-1-vaibhav@linux.ibm.com> (Vaibhav Jain's
 message of "Tue, 6 Aug 2019 16:20:12 +0530")
Message-ID: <x497e7igipm.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 12 Aug 2019 21:46:46 +0000 (UTC)
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
Cc: Harish Sriram <harish@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> On PPC64 which uses a 64K page-size, ndtl-check command fails on a BTT
> namespace with following error:
>
> $ sudo ndctl check-namespace namespace0.0 -vv
>   namespace0.0: namespace_check: checking namespace0.0
>   namespace0.0: btt_discover_arenas: found 1 BTT arena
>   namespace0.0: btt_create_mappings: mmap arena[0].info [sz = 0x1000, off = 0x1000] failed: Invalid argument
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
> v3:
> * Fixed a log string that was splitted across multiple lines [Vishal]
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
> ---
>  ndctl/check.c | 93 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 67 insertions(+), 26 deletions(-)
>
> diff --git a/ndctl/check.c b/ndctl/check.c
> index 8a7125053865..5969012eba84 100644
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

Don't you have to ensure that the length is also a multiple of the
system page size?

-Jeff

> +
> +	addr = mmap(NULL, length, prot_flags, MAP_SHARED, bttc->fd, offset);
> +
> +	/* If needed fixup the return pointer to correct offset requested */
> +	if (addr != MAP_FAILED)
> +		addr += page_offset;
> +
> +	dbg(bttc, "addr = %p, length = %#lx, offset = %#lx, page_offset = %#lx\n",
> +	    (void *) addr, length, offset, page_offset);
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
> +	dbg(bttc, "addr = %p, length = %#lx, page_offset = %#lx\n",
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
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
