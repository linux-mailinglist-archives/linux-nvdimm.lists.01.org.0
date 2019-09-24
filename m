Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D2BD0D5
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Sep 2019 19:44:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 327FE202F73BA;
	Tue, 24 Sep 2019 10:46:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D73FA202EF27C
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 10:46:25 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w17so2422482oiw.8
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pwi3v3/eeuCMJP1kakBxgsx/z8MzTJMBZi3TcsuXfD8=;
 b=xHa5Le0bFjzzgtu4UA+qX7oT9GocKtBq7Xl37UBLzT6F80XgwshE/KJRo7/gDT05dz
 cKG0ASrlUMYJrRC8oMXfluJtGFlg638AdkIt7mYU4shAe3LfWelo3DxXudA4uCBikTL2
 oK9XKKbaXC0KqUAjkzYGDbuR8AEnOObj0aULTTU8LlJihmNXrH73ee77BwMcjt6BQziG
 uYJNTPGo5QSv1/6VZM66TO5qNHs1r/eiEx3nsiINou8l2Ijbo8Q5FMtfi+iDYB7PlidU
 b9oD/50kCmsSHA4rWxnDmZS8i3KZAZR5O27FCZoOq5UjBlx/c785AlJAguM6DQfbs9Qx
 eMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pwi3v3/eeuCMJP1kakBxgsx/z8MzTJMBZi3TcsuXfD8=;
 b=CwRmya9JBuQYLfbOQukefbAG4wtr9Nu+kavySu6blXJscGojvAfnI+3aD5z3b2MU5R
 RugRsJtsnlDqBFbPOPAh37NHbZ5lk33XdHRvNVnnJjbNB11ouafflX8kKox/sNRaau8v
 7Qlc6DGOUrbN+zZZIXZxUvopDtgEKrjXn+/fzdMbT8ZKfxwWHtEudJldCT9R+Qj/R1mk
 5hlX7AG0BulvR8atOcLpNN0EquEVnzXrI0oZN4PhcoVQwD5BN7h4skjGy5u59FhXd89h
 qtYtDn1cqqlBZWSe/71iN4qpWJHcXvz/ldoW9fc3ZmkAPaAp3ohf/fgC3lOrQJyMYCz7
 k2xA==
X-Gm-Message-State: APjAAAVu0Bp7d5sAMlPEe4Bt/PL6Fe/P+9z6QNrVC9exiK7n6NNueeGo
 nT1Pnr8jxtGt6A/RqZG/3jJfzbpLq31HpWOtmebEeYzj
X-Google-Smtp-Source: APXvYqydfSZkrqS0gdUrhVzS5ly9nrwL9bfZ+wnPoCLrlEThrki+tInTEXBQDioYJbfPYimPhkF297yYxBp1sB+LQ4A=
X-Received: by 2002:aca:df88:: with SMTP id w130mr1287076oig.0.1569347044056; 
 Tue, 24 Sep 2019 10:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <156934642272.30222.5230162488753445916.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <156934642272.30222.5230162488753445916.stgit@djiang5-desk3.ch.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Sep 2019 10:43:53 -0700
Message-ID: <CAPcyv4huSU2PAd48Z5UYCR7NXgaRVhrE38WkaWPP4MUjpCwgyw@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: prevent nvdimm from requesting key when
 security is disabled
To: Dave Jiang <dave.jiang@intel.com>
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
Cc: jthumshirn@suse.com, peter.stark@ts.fujitsu.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 24, 2019 at 10:35 AM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Current implementation attempts to request keys from the keyring even when
> security is not enabled. Change behavior so when security is disabled it
> will skip key request.
>
> Error messages seen when no keys are installed and libnvdimm is loaded:
>
> request-key[4598]: Cannot find command to construct key 661489677
> request-key[4606]: Cannot find command to construct key 34713726
> ...
>
> Fixes: 4c6926a23b76 ("acpi/nfit, libnvdimm: Add unlock of nvdimm support for Intel DIMMs")
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>
> v2:
> - Fix up commit header to add more information and cc stable. (Dan)

Looks, good, applied.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
