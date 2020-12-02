Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3412CC9B1
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Dec 2020 23:38:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 95240100EBB8D;
	Wed,  2 Dec 2020 14:38:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=yi.zhang@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C5A68100EBB8C
	for <linux-nvdimm@lists.01.org>; Wed,  2 Dec 2020 14:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1606948698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hFEYOz9SQEO5g/Hxds9W0B7cSaL5INIcyasu2Z9rU0=;
	b=ZBmwPhpzxDQ0eRtgOEBONjcX98SYMSaptBsDYmSEnfwrWAnysgKxzot/NdjxkHyFGOieEc
	kyuMgNjGlUaLIoKI42jqXyri5OIXKVpCp5BGlxweP/Bt2NC5QNqgSyZB8o5YtzjTVo9wvy
	DYJ92m8o0IjUbyWTJz3e+rxuGZdX5/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-ccHfYQ8gOzWm5WGlXMYClA-1; Wed, 02 Dec 2020 17:38:05 -0500
X-MC-Unique: ccHfYQ8gOzWm5WGlXMYClA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6C1339388;
	Wed,  2 Dec 2020 22:38:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E2E19C44;
	Wed,  2 Dec 2020 22:37:59 +0000 (UTC)
Subject: Re: mapcount corruption regression
To: Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
 <20201201022412.GG4327@casper.infradead.org>
 <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
 <20201201204900.GC11935@casper.infradead.org>
 <CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com>
 <20201202034308.GD11935@casper.infradead.org>
 <CAPcyv4jk2-6hRZAC+=-wuXwFyYK9uKiRX=pVc0Q0UeB9yc=y1w@mail.gmail.com>
 <CAPcyv4hxuzn9k-W_+iBsa=evL-FGijWyaxkyFLohUTqCCoJAig@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <709287b1-dedf-3bff-e46a-8aa19ad774fb@redhat.com>
Date: Thu, 3 Dec 2020 06:37:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hxuzn9k-W_+iBsa=evL-FGijWyaxkyFLohUTqCCoJAig@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: 7WRZGZOTTQFZGTZH7KWZ4QZ4XYBJUKMF
X-Message-ID-Hash: 7WRZGZOTTQFZGTZH7KWZ4QZ4XYBJUKMF
X-MailFrom: yi.zhang@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Shutemov, Kirill" <kirill.shutemov@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vlastimil Babka <vbabka@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7WRZGZOTTQFZGTZH7KWZ4QZ4XYBJUKMF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi Dan
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index dfd82f51ba66..7ed99314dcdf 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -829,6 +829,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>          }
>
>          free_page((unsigned long)pmd_sv);
> +       pgtable_pmd_page_dtor(virt_to_page(pmd));
>          free_page((unsigned long)pmd);
>
>          return 1;
>
> In 2013 Kirill noticed that he missed a pmd page table free site:
>
>      c283610e44ec x86, mm: do not leak page->ptl for pmd page tables
>
> In 2018 Toshi added a new pmd page table free site without the destructor:
>
>      28ee90fe6048 x86/mm: implement free pmd/pte page interfaces
>
> In 2020 Willy adds PG_table accounting that flags the missing
> pgtable_pmd_page_dtor()
>
> Yi, I would appreciate a confirmation that the fix works for you.
>
I applied the patch to v5.10-rc3 ~ v5.10-rc6, and cannot reproduce this 
issue with my regression test now, feel free to add:
Tested-by: Yi Zhang <yi.zhang@redhat.com>


Thanks
Yi
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
