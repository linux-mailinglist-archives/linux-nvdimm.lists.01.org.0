Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF6C19AF4C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 18:05:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EB54710FC363D;
	Wed,  1 Apr 2020 09:06:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com; envelope-from=jbi.octave@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4CB2D10FC3618
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 09:06:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 31so725794wrs.3
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=x0iGf5X4LVYTv3/i+3RQO+ppyXBQZXoUL8LL0fm5I0w=;
        b=EXpjA8rTQUsKE+qdZqP/OdGd6eCxiipdusbCGRdMgrzSFDoTFfrG8GcWy5dSL+FGAu
         ZmAiMwADAOV9LvQ0JMLfaxNcfPTrWpQPuPaPxkK5bZQwQt4WNNGxNy2baRVZYXVIP5rT
         6UR1mJoZ5uwMwQR09xEaxeei29Umc1sb9HHkqSPRgThc+AkTmVWz8YPHKtYWLcItT0IF
         rv4j9Om54xQbV/ZQtczS930PXJ/ze/EcF3UEvLj0otsGO+DW7cena5EZ7doG/84pnfO+
         CO4Dlu39M6co2U7plhwPYNFD+2FDjGLuLuk7vU057+iIupH64dmPnABgUU6YlwoYav9W
         x7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=x0iGf5X4LVYTv3/i+3RQO+ppyXBQZXoUL8LL0fm5I0w=;
        b=LE/wMOV9j+nirDk0VTME5OrbK+ylMnCaVZbvPPpyBXlDto0/0yehbv/qfkuZytxD+Y
         CYCSM/6dUt5F7vmFW+SR7GeI12+/DaFFjVnSuO8pnK2/95FzGB9KdGE7oUZctFF/nbzj
         +TtZj1YYE6xMu5E6B6F1dCMi8FW6j1crmlRkMGFtx4VF8Wncv16tDAhRo6YDi66gAdO1
         Vjaxh2/uy1+V0iYdA5A+9BySa3iHd1NruKhgEqVMnP/cV0eTlymKvxkoXaMH3x+9IiMH
         UQRkesrG005mw/eOpb5cG2DMKyWP/BWopDCyt+do2WyhlMeqKhjc0XVudBQVAYyYdMlu
         n36A==
X-Gm-Message-State: ANhLgQ3rJOsmiO57ReG8Yqlp/Uvl2aKrCD4nCdE5EtuNeQ4eT+RMkHI0
	Gi5fvzdGHMjruTScKNMUeEJzrO2k//D4
X-Google-Smtp-Source: ADFU+vsGgsO5O4k/Oz4y3nId5ruptaNQ0NK34qLOhjZcXf6pDS0gcYHgxF/Tk6yhVtQY7TgTs81tYg==
X-Received: by 2002:a5d:460f:: with SMTP id t15mr26748856wrq.413.1585757108643;
        Wed, 01 Apr 2020 09:05:08 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id i21sm3321949wmb.23.2020.04.01.09.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:05:08 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <djed@earth.lan>
Date: Wed, 1 Apr 2020 17:04:54 +0100 (BST)
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/7] dax: Add missing annotation for
 wait_entry_unlocked()
In-Reply-To: <20200401100125.GB19466@quack2.suse.cz>
Message-ID: <alpine.LFD.2.21.2004011702002.25676@earth.lan>
References: <0/7> <20200331204643.11262-1-jbi.octave@gmail.com> <20200331204643.11262-4-jbi.octave@gmail.com> <20200401100125.GB19466@quack2.suse.cz>
MIME-Version: 1.0
Message-ID-Hash: 2UA6TRER6UJ7QSZHXC5LJSWF6BYMJ6ZM
X-Message-ID-Hash: 2UA6TRER6UJ7QSZHXC5LJSWF6BYMJ6ZM
X-MailFrom: jbi.octave@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org, boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:FILESYSTEM DIRECT ACCESS (DAX)" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2UA6TRER6UJ7QSZHXC5LJSWF6BYMJ6ZM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On Wed, 1 Apr 2020, Jan Kara wrote:

> On Tue 31-03-20 21:46:39, Jules Irenge wrote:
>> Sparse reports a warning at wait_entry_unlocked()
>>
>> warning: context imbalance in wait_entry_unlocked()
>> 	- unexpected unlock
>>
>> The root cause is the missing annotation at wait_entry_unlocked()
>> Add the missing __releases(xa) annotation.
>>
>> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
>> ---
>>  fs/dax.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 1f1f0201cad1..adcd2a57fbad 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
>>   * After we call xas_unlock_irq(), we cannot touch xas->xa.
>>   */
>>  static void wait_entry_unlocked(struct xa_state *xas, void *entry)
>> +	__releases(xa)
>
> Thanks for the patch but is this a proper sparse annotation? I'd rather
> expect something like __releases(xas->xa->xa_lock) here...
>
> 								Honza
>
>>  {
>>  	struct wait_exceptional_entry_queue ewait;
>>  	wait_queue_head_t *wq;
>> --
>> 2.24.1
>>
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>
Thanks for the kind reply. I learned and changed. If there is a further 
issue, please do not hesitate to contact me.
Thanks,
Jules
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
