Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A8DCF30
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 21:17:01 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9516010FCB398;
	Fri, 18 Oct 2019 12:19:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0C9B10FCB397
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 12:19:03 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c10so5873316otd.9
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9lvg70j9nj03vvbL2ubjt+5daD5TWzoAys2EGOhvsw=;
        b=NVqle/026PDvkYCWn+PmNnnG0FOO9bbqokCqh8fbdtjV5nMXiM7QQkt7vfFC/sefMV
         K6FqN0Drp+Qq57RH5QguQzmF6xRAZ8d6Ag/F3PBtOIDPdviHZitjoYuvp5X8JwNnlUJN
         07ziW+AnCb+VXc2vs6pir2HCtYKH7Gz5VEgC9IlkdB/q2ihvP3fFRYVBeYHbCXzZub/l
         e2xnb2ZWf6b4Kz1+uemddRv4k45sZMIkG5wyQVGKhRROtBlRBYNRLVL00yCv0ueq5WLT
         vOKW35ZFdTH4rQjOxvN3kx7pBKeeiTPRA4ev3Rv8omEUjZG7Ves6q2px/QKUldTCCZb5
         9fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9lvg70j9nj03vvbL2ubjt+5daD5TWzoAys2EGOhvsw=;
        b=IlYKDrnQV0Qkw1Q7cxmFKyVXf7UDEb+jlJglEFu0hpQznIfRnqSBZcrW218kCfddtU
         ns9CEPDMu41VdoGWx+9vDOdg/eZw/J70hhByl+SIikHcwVTaWr1A4D68Ky9Sbjp+3FP2
         FOzA52ubmx4OH8qg1spjh63G90vLESPucTlC5wCq5hFQ1LfvlpgoOYMzPMp3WSQJoVby
         cUsd31RDj+dibpLkPoSyEyZpveCBfWT1S86VsBQxD1QtNuytCP0ejFoIM/sIc5dNPD59
         ZjnzaNKEx0/CL/lqDrceZG9lSeH5kO/FlDVWj0JT+YxyaIheouj2qGJthNoUzUqWMWG3
         YiBw==
X-Gm-Message-State: APjAAAXe02Ta5OUP5zm7vHfS2hpx1+cdD6jIyzAytCA0uNPcRNwnz+PA
	9lETqCC5bY9mgqaNXoDSbXqAw+Idv+oDY8Eslnvi0J4QeJ8=
X-Google-Smtp-Source: APXvYqzCsHWN26f2SUmBCDLz5wfHiGcc8Pm+KhOxFLNGNFYTCNQJ6Ot170UOUDlbUcmgkCFzF+2bRolabfD6Z/Yx9+4=
X-Received: by 2002:a9d:7843:: with SMTP id c3mr8360072otm.71.1571426217290;
 Fri, 18 Oct 2019 12:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-7-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-7-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 12:16:46 -0700
Message-ID: <CAPcyv4i9NjfwfijcA1ps1DGFLKOyWHUXp+U1pj_HouLn5Ook0w@mail.gmail.com>
Subject: Re: [ndctl PATCH 06/10] daxctl: show a 'movable' attribute in device listings
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: 66CQSWOS6EIUSBNPPIPKDGTXSJJSOPR5
X-Message-ID-Hash: 66CQSWOS6EIUSBNPPIPKDGTXSJJSOPR5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/66CQSWOS6EIUSBNPPIPKDGTXSJJSOPR5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> For dax devices in 'system-ram' mode, display a 'movable' attribute in
> device listings. This helps a user easily determine if memory was not
> onlined in the expected way for any reason.
>
> Link: https://github.com/pmem/ndctl/issues/110
> Reported-by: Ben Olson <ben.olson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
