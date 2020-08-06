Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3785F23E457
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Aug 2020 01:24:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70A9E12BEE455;
	Thu,  6 Aug 2020 16:24:08 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=kirill@shutemov.name; receiver=<UNKNOWN> 
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BAEE412BEE455
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 16:24:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so170684ljc.10
        for <linux-nvdimm@lists.01.org>; Thu, 06 Aug 2020 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VgoGp2DsY5zPhxqgq4Oy4vGUjLnQwWQ4gdyr/irKbY4=;
        b=KKjv6IjJr551lE/pPran8bv8Ogy5tkDSNLx76eFZojKkUnVAn2sW5C+XQ3q8V2XFLA
         V7+Wn1pUyanc8nJFL9bTVroQYKH3the5ZGn3R83H4HGh9TIOvNCDCdkPUFk9G7PJ8trd
         jinz+MsfUDev7qSSJMzyxMJeIgW672xXAPhb1ZsqAhs0x+WalXFxXX1BBlL7yuzxyfft
         282qE4rzfyui+Gpk/nneyyJGnOKcnJorIshj0AKBI9lfPlGQfORQ/FpXU8HFt6ymBdYG
         65XEiehWmKpvlMEBxKO6PUpzrSFuXtbh07scxPiU/bbYUUq7xzkGS894iUxwKD8+PzyN
         h2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VgoGp2DsY5zPhxqgq4Oy4vGUjLnQwWQ4gdyr/irKbY4=;
        b=l/060oDBDj7lgxKKUZY8sy4UEDcBMbZNac+1jhELIk6aBe5wT8Uj5lzj9lI9S4YMve
         lwHpxTz68uu1JIyITXsI8DsnBTYwAAXu6jWuyUIHXCeOet+QULTolLGR2LutTpdw9be8
         5TMBa8pD7zVZlUFXMO6FjxGFhH+X20MvTJkS++js+Ri7nBeAEBhGRZsljUzV0MDfrarA
         qT2EmCKsKsJ9ZC0DI9IIeIrQ3hn2sh/qOl3CPu2Cakf6hXXssQITbpxmHlnrhsrXec/0
         HiYjU3dqcsIutFlgug1humwH+5zpNP9l/9g9ALUm+ATJKl57f15t4gAN4hjnjjYyxqQ/
         oClA==
X-Gm-Message-State: AOAM530MHVc1G/qQJHrL9zMcMybpJOF7T2ifkFJ1Nd2lrTTt8yatsXLz
	esKoxALP2OVp4kj/DtcDJ7coKw==
X-Google-Smtp-Source: ABdhPJyBZ5SbubFpFJf+5IGHmjYhSBID5NxEHXK4QhhnQaAU6p2DsBsTuKPl3r88jI+j0IrrKSEqnw==
X-Received: by 2002:a2e:91d4:: with SMTP id u20mr4619135ljg.87.1596756242133;
        Thu, 06 Aug 2020 16:24:02 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g24sm3063504ljl.139.2020.08.06.16.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 16:24:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
	id D228C102F9C; Fri,  7 Aug 2020 02:24:00 +0300 (+03)
Date: Fri, 7 Aug 2020 02:24:00 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 1/4] mm: Introduce and use page_cache_empty
Message-ID: <20200806232400.s7nhmnoi3tkk7p2r@box>
References: <20200804161755.10100-1-willy@infradead.org>
 <20200804161755.10100-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200804161755.10100-2-willy@infradead.org>
Message-ID-Hash: ITTXXRJR3LJVXNXJZ5SOZ6POVA5WYKRR
X-Message-ID-Hash: ITTXXRJR3LJVXNXJZ5SOZ6POVA5WYKRR
X-MailFrom: kirill@shutemov.name
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ITTXXRJR3LJVXNXJZ5SOZ6POVA5WYKRR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 04, 2020 at 05:17:52PM +0100, Matthew Wilcox (Oracle) wrote:
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 484a36185bb5..a474a92a2a72 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -18,6 +18,11 @@
>  
>  struct pagevec;
>  
> +static inline bool page_cache_empty(struct address_space *mapping)
> +{
> +	return xa_empty(&mapping->i_pages);

What about something like

	bool empty = xa_empty(&mapping->i_pages);
	VM_BUG_ON(empty && mapping->nrpages);
	return empty;

?

> +}
> +
>  /*
>   * Bits in mapping->flags.
>   */

-- 
 Kirill A. Shutemov
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
