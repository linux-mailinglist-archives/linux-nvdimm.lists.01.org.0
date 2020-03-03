Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A54178483
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Mar 2020 22:05:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB14310FC33F2;
	Tue,  3 Mar 2020 13:06:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BDEF51007B191
	for <linux-nvdimm@lists.01.org>; Tue,  3 Mar 2020 13:06:09 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id g96so4489904otb.13
        for <linux-nvdimm@lists.01.org>; Tue, 03 Mar 2020 13:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzOHtKGs9vZUhp4iJiSpFDnza7AMdo8xQNIINvLoq4c=;
        b=hxP4lIb3dtmkBovQg4J33LlZEIywlSg2jVUfXOWBxBq3jnVfA8X86T/EvwrGfIQN6J
         /U0KTguX05L4aeZDQqURd07a+65UXJDiwXo2Hg/WCtZ01L9UdLnT1dw/Y5xkFtSbh3wT
         KwBr/znV1ED2tk+oTlKcXyLCAfoYeUVaUamLHipAHlZ7+c1K4taxz0B+9wj2YfoJcY0C
         jVzdVuIzRHq3jBlpSZhQsHhta3ZSwGpiWSBJIcpes57QFdrmy2E1a72QuTfa2LvjEVPI
         2cqebxXVHXVE9zoxEc3vdJ+gdWv2Xf8wpW+SMqNOxe4GX651CrTTLR62jFVMk+Hwovzg
         jRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzOHtKGs9vZUhp4iJiSpFDnza7AMdo8xQNIINvLoq4c=;
        b=eEhooWzeYj9+7U/D5WjVlUNsN8NR5mZ8HrrdRvESqX+Vm5cgxcddwY4fFFNsaE9UNi
         ToosiJmsfhm7Z6Sr2XKoTHmHsqhhZTQMOtZJG5/5STO3+USgqKCHvtHnRhHV9BP8WJ7x
         STPulGqIicB/Er6EyxLPp3kUlqdaJl8tH/ZxbY5DqonIPPK6RTy94tq6kj1RmUvdIXEt
         aa4cHk2+NkHMUqhi7tm4MRYTD8fpihgW15ULO54r0fR9Ozd5J23ckyFNSCQ+HZNmPfGV
         j1xAKW2mQehGTcgSMO9SEEBSN+GuyA2h8lWPN+pA32M8iEZyNTWKAaHsheD7qkgZYbmc
         iZ4A==
X-Gm-Message-State: ANhLgQ1AKFQHylW+PlKgtYLqzVitHanunm/5gtf+FY8qTHcmILTkFslj
	7gq+CqncWInHphk1U2B2FwUWAzm++4t9TGL2zDW7AA==
X-Google-Smtp-Source: ADFU+vtCfyS/jHwngdV6cCYqTsmvzxcXe2ZONSCzpDj8RX1/4saFBNdCkAD+FfiZ07o38wO338ZCc0dV5o6mLRiRfTI=
X-Received: by 2002:a9d:6c9:: with SMTP id 67mr5029384otx.363.1583269517447;
 Tue, 03 Mar 2020 13:05:17 -0800 (PST)
MIME-Version: 1.0
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158300774836.2141307.13052648687237614794.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200303132850.GA21048@quack2.suse.cz>
In-Reply-To: <20200303132850.GA21048@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Mar 2020 13:05:06 -0800
Message-ID: <CAPcyv4h7mKJ69bnQ0VSeeg74m_jrhJU6X4SY9yPn=A5Rv2u4FA@mail.gmail.com>
Subject: Re: [ndctl PATCH 27/36] ndctl/test: Relax dax_pmem_compat requirement
To: Jan Kara <jack@suse.cz>
Message-ID-Hash: YXKEKKI7Y3VEZDUQH45KJSJZDHMRPWT6
X-Message-ID-Hash: YXKEKKI7Y3VEZDUQH45KJSJZDHMRPWT6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YXKEKKI7Y3VEZDUQH45KJSJZDHMRPWT6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 3, 2020 at 5:29 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 29-02-20 12:22:28, Dan Williams wrote:
> > While there are some tests that require the new "dax-bus" device model,
> > none of the tests require compatibility mode. Drop the requirement so
> > the tests work with DEV_DAX_PMEM_COMPAT=n kernels.
> >
> > Link: http://lore.kernel.org/r/20200123154720.12097-1-jack@suse.cz
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> The patch looks good to me. Thanks for fixing this! I just have to say that
> the strstr(3) usage in this function looks rather unusual to me. Why not
> just strcmp(3)?

Yeah, this is confusing the 'name' check with the 'path' check, the
name check should be fine to use strcmp(). Will fix up.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
