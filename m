Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A5B2DDAF9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 22:49:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A9B2A100EB852;
	Thu, 17 Dec 2020 13:49:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A14F4100EBB96
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 13:49:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id lt17so251358ejb.3
        for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 13:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cZn0/VDIP8GuviNxwhziCIcMwTUnEGXU1Czf1LyLZ0=;
        b=kCArAph5EJpFqMvdN6tKtStdOo19rKqUKa9IxW5p0saZdwtA0uSMgEURq7Jpa8QKv5
         dW2djHch1dT5Wxq3MghYB94RUP+nQFvCIHAuwAUI3oYGVdJJhGjYJ2/TI5mPbmZ4CQZm
         xb03ERR8QRpeoTVQxS+WTaS066+yNPVG0mbBhlJFAc+GvttyVEoNDbngyziUMtD1M/wF
         NDDDWbAOKepGu+g6M9uWvgshzz/uokz/B8YoK/88DBCLQDQSgpLEXG9q7/rET2FQ1bWG
         mD8VJwnLcWKksVoNPbAqVre4LfJfo69oU8b00FXmjCl82cTxp2DUxsKW3RBfde1c88pV
         J/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cZn0/VDIP8GuviNxwhziCIcMwTUnEGXU1Czf1LyLZ0=;
        b=MiV+7VInSKXzrfSeuprmwHDmGjKLDViwJ7K+A7cqlzcTcDByo1UhNlqSLT/pmeahqn
         ymjwaufKTQhumm9PBtxQAqf5toILPmfibg2ZKaN871vV2cKXSa3wNvTNl1NmlwlxHoNv
         2AjzFILX+YPWhqMubN2fWGbF6TDH0pozeLBpHHxHP6cNZlzuCoF4bV5W6ceGBDkWDWKB
         UD+oy9R+Y2pNIIsLClNhXpDH3sgm0wErLt9KFcxAHgdSTGAZI8oEVdKW9+a3+JpTs7UW
         Do8/3R5gYhcFVjpXvk1jeURqnkV0HR5LdFuCpBVnQ+OOxQzZ8V9j0E3N3KPoT1t2N9LY
         //XA==
X-Gm-Message-State: AOAM533FINlOyor8UYo0aXCwkSwKrUue4LRrxd24oDB5fPXlsO5IWiKh
	G6Y7vz5dbtNLTPW+mUvDntvAXR1dZu2CiFcCdwwTCg==
X-Google-Smtp-Source: ABdhPJwHnoPTmwaKTlKlW0KQTQMxXtV8C/5O6HNYiljCloUk6q7XDy83A/EPUyLdZemvaQVbJmVyjA8hnnz/4KoNMe0=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr1078927ejc.418.1608241761522;
 Thu, 17 Dec 2020 13:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20201120092057.2144-1-thunder.leizhen@huawei.com> <7ccddd02-e2e6-ec48-43b8-10700285e61c@huawei.com>
In-Reply-To: <7ccddd02-e2e6-ec48-43b8-10700285e61c@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Dec 2020 13:49:11 -0800
Message-ID: <CAPcyv4hLoqYpLxQhPhGA2XxJPOc6VkonjrHSbyEQa2Y=voF8hg@mail.gmail.com>
Subject: Re: [PATCH 1/1] device-dax: delete a redundancy check in dev_dax_validate_align()
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID-Hash: 5ATQ4GQ262KU7V74RDBDDHLSIEDKFPL3
X-Message-ID-Hash: 5ATQ4GQ262KU7V74RDBDDHLSIEDKFPL3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ATQ4GQ262KU7V74RDBDDHLSIEDKFPL3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 20, 2020 at 1:27 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/11/20 17:20, Zhen Lei wrote:
> > After we have done the alignment check for the length of each range, the
> > alignment check for dev_dax_size(dev_dax) is no longer needed, because it
> > get the sum of the length of each range.
>
> For example:
> x/M + y/M = (x + y)/M
> If x/M is a integer and y/M is also a integer, then (x + y)/M must be a integer.
>

True... I was going to say that the different error messages might be
useful, but those are debug statements anyways, so I'll apply this.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
