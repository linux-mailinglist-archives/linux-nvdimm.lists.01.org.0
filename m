Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333EFDCAC2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 18:16:49 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4CE05100DC1EC;
	Fri, 18 Oct 2019 09:18:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D8B21100DC1EB
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 09:18:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g13so5414773otp.8
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yvne9gR5NX8diVvQ4owtsBgM2mX2Xb63EAQlH8HuKk=;
        b=pgtBz1yNdYHNJjI2qaamNbVambOK9yJQgeULnvuFlYsPJ9Rjw1N2d9H+8UMr9eWj3b
         9liGZz4th/SqPt1msrv5ZhJ9X9azJiH5HNasIcgScD598JWlRWnzuFGS5AXysqgA6HLk
         gwKe5zRem+TLue5OOjkQh/IQhuxj1AIg1HfVEcb//hOpoKtgw5H/2dP9kiqZLYOx1QBF
         SrL6WQzrY22NyTxaL8lcVppjuosDDGcqNgrGBBEmn5Oh8WYlAZ4hC7itFji5GF+ZbDMS
         QAID4k1OHaUbZNUNfqTZiKItV2l49Gld9cwb/kfcjD69FsTkXtRptAEHg/UKD/mgPmFj
         rfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yvne9gR5NX8diVvQ4owtsBgM2mX2Xb63EAQlH8HuKk=;
        b=Ycyfk7Fpg2Ef5eU3FT4vTWkiI3XaH+KXl0eVGRaxH5yyLM/RkBHq9uep0WSdL7YUlc
         oIVdB1bc133I2PtSEywMqGg/hdXSsRIhDcfbumg4S6hFxiDxa/6y2pznkewMUqo415ov
         tMS39UA6clVDGQzEtUcnJta50U4OmY1Vre8agbOueM+KWChun57rwJ+td3uG6yvkvkSI
         kVBlq9N1ChIVI0y8J5Z/Odd6TxQBMJ3exUYbhTCTEMbTchK7zhqmDnGc5zy2Jj876C57
         d1yy5pY3ujig0fRUMdo1GVu/LHiB8QzRz+UXj70hWpt+eYI6yymbx55JUh6l1/NF5nhk
         O6rA==
X-Gm-Message-State: APjAAAWvACd7umAcBJ3BYpvT6pw+EZTdn9zTABZ7BZobAcflStW0SSRi
	bmGyH8Q1j+AUkacsiVF9bFImnss5Jc+eaajv8oVixA==
X-Google-Smtp-Source: APXvYqyblv3J/xJHeQdDv4C30Sjo0Fd3shSE2mry0JpF/Y+67xf+0kg0irQ3y+5bIupfWe2BJ5cEte7rGplRl+cUL8w=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr8454155otn.363.1571415404227;
 Fri, 18 Oct 2019 09:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018123534.GA6549@mwanda>
In-Reply-To: <20191018123534.GA6549@mwanda>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 09:16:33 -0700
Message-ID: <CAPcyv4jm7kiayfHnBcm7mNW2NeJ81LeUVphMYG0Tq50is-tQ0A@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: unlock on error in scrub_show()
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID-Hash: HHK6RCYTHIW424AMZGVGRZPKBGFXCB3N
X-Message-ID-Hash: HHK6RCYTHIW424AMZGVGRZPKBGFXCB3N
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HHK6RCYTHIW424AMZGVGRZPKBGFXCB3N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2019 at 5:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We change the locking in this function and forgot to update this error
> path so we are accidentally still holding the "dev->lockdep_mutex".
>
> Fixes: 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good to me, thanks Dan.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
