Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B482FF641
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 21:47:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2BBF4100F2255;
	Thu, 21 Jan 2021 12:47:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN> 
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 04928100F2254
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 12:47:13 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d85so3090019qkg.5
        for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 12:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/tjtwUwUvkuiNzh76iFV5D8ld1zMDjPWbiessv/dJqU=;
        b=eUKNXJ8zM0JVfJmpFlkOcDWi/HpkA4Uw6XaHP1IH6XXbjYEGcAVUIzwoxYg8m+D38E
         ss5ZPoXyoi9Xwb9ajsHZfgzJDT/cpYDGYmst+Wl313IwLh3AuzCyMZZ6r02R2f5DXBJH
         10sqQ/VivdnaE4iRz4JkrV+o9J647jXPijoHbhwInhj7QHvPMu88PVFFA4W2CXTiXdnA
         eZ23W2p996RCtZE76TjeHcgXf8I3SNkyj6M2Mrs2dO4NmIpwccXKeXM6GO9QkW9ajc4c
         95z97HPxvBxlqlf/UkiJW153pa7YA5bV7+Loih+MO8mnKrfQO4m/r7hbHCDBfWDe6Kku
         ym8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/tjtwUwUvkuiNzh76iFV5D8ld1zMDjPWbiessv/dJqU=;
        b=co9EvPqxeCad1cjwK2xJtUOuHwjCdbrfm9b1q5vZyK1z/Q9XZrMLlib94e6hS5k8Ac
         E0En17smY1ReitBpJ8Bm/uJW6AXcCSjUgq22FSdXYiwJ0pjM6WRwJ+X0QFn2a0MLWYUe
         9fQRfjL/U/4C2KQ+SI8mY4T/7FvlmBfmDGp7i3LLRQYZ/jUk8ekDYjGSO/0pQsDtYOkZ
         nZMNP9+QRcOdv10LbKlPokXioUWOwC6jFmz5nJ7cQo1y5ba0T5Ps6d8sbNWS4aa+EWkC
         jsfercTt4nUhJpZr97JjqriNLFRKLVArcwLDY0AIJbEG02Cy09jVuKpQAfKtb6geCOpx
         1gpg==
X-Gm-Message-State: AOAM532tdP/nqBz48Df/v4ubqwbucBpygjVYk8tzTTShem3sNIlzMzPm
	PvkJXlzRHgJY0Bo3YtBfMpWkDg==
X-Google-Smtp-Source: ABdhPJymQ68qH/Kk5Gv0vW1cNoekc6T0599882PqygAgCoQEki5Ud+OOT6jsiKXim3g3Bq/F5NrofQ==
X-Received: by 2002:a05:620a:15d0:: with SMTP id o16mr1792985qkm.222.1611262032268;
        Thu, 21 Jan 2021 12:47:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b808])
        by smtp.gmail.com with ESMTPSA id f26sm4184194qtp.97.2021.01.21.12.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:47:11 -0800 (PST)
Date: Thu, 21 Jan 2021 15:47:10 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 4/4] mm: Remove nrexceptional from inode
Message-ID: <YAnoTo1BNADBjL9u@cmpxchg.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-5-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-5-willy@infradead.org>
Message-ID-Hash: YBSCL7SSPSVDRIMCMHBTDFOLLW3JJLIA
X-Message-ID-Hash: YBSCL7SSPSVDRIMCMHBTDFOLLW3JJLIA
X-MailFrom: hannes@cmpxchg.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YBSCL7SSPSVDRIMCMHBTDFOLLW3JJLIA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 26, 2020 at 03:18:49PM +0000, Matthew Wilcox (Oracle) wrote:
> We no longer track anything in nrexceptional, so remove it, saving 8
> bytes per inode.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
